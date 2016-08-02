MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

################
# Utilities

# $(call make-lazy FOO) will turn FOO into a variable that, when accessed, will
# evaluate its definition once and then remember that value for the rest of the
# makefile. For example:
#
#   FOO = $(shell date +%s)
#   $(call make-lazy FOO)
#   t0 := $(FOO)
#   $(shell sleep 3)
#   t1 := $(FOO)
#
# Without the make-lazy call, $(t0) and $(t1) will have different values, but
# with it, they will have the same values.
#
# $(1) = name of variable to make lazy
make-lazy = $(eval $1 = $​$(eval $1 := $(value $(1)))$​$($1))

# Used for backups
date := $(shell date +%Y%m%d%H%M%S)

################
# Environment variables

ifndef ENV
ENV :=
endif

ifndef DOCKER
DOCKER := $(shell which docker 2>/dev/null)
endif

ifndef DOCKER_COMPOSE
DOCKER_COMPOSE := $(shell which docker-compose 2>/dev/null)
endif

################
# Sanity checks and local variables

ifeq ($(DOCKER),)
$(error 'docker' executable not found)
endif

ifeq ($(DOCKER_COMPOSE),)
$(error 'docker-compose' executable not found)
endif

valid_env := local dev stage prod backup
ifeq ($(filter $(ENV),$(valid_env)),)
$(error $$ENV ('$(ENV)') should be one of $(valid_env))
endif

env_file := .env
$(shell test -e $(env_file) || cp $(env_file:=.base) $(env_file))
ifeq ($(wildcard $(env_file)),)
$(warn $(env_file) does not exist)
endif

docker_compose_file := docker-compose.$(ENV).yml
ifeq ($(wildcard $(docker_compose_file)),)
$(error $(docker_compose_file) does not exist)
endif

docker_compose_command := \
	$(DOCKER_COMPOSE) -f $(docker_compose_file)

complain-if-not-configured :=

ifeq ($(CONFIGURED),false)
complain-if-not-configured := @echo "Configure the .env file"; false
endif

################
# .env variables
define newline


endef

# Somewhat hacky code to load the variables from the current .env file into our
# makefile so that we can use them
$(eval \
  $(subst @@@,$(newline),\
    $(shell \
while true; do \
  read line || break; \
  [ "$${#line}" -eq 0 ] && continue; \
  [ "$${line:0:1}" = "#" ] && continue; \
  var=$${line%%=*}; \
  value=$${line#*=}; \
  echo "define $$var@@@$$value@@@endef@@@export $$var@@@"; \
  done <$(env_file) \
)))

################
# Exported variables

export ENV_FILE := $(env_file)
export DOCKER_COMPOSE_FILE := $(docker_compose_file)
export DATE := $(date)

################
# Standard targets

.PHONY: all
all: | up
	$(MAKE) -j 2 logs watch

.PHONY: check
check:
	$(docker_compose_command) config -q

.PHONY: clean
clean:
	find . -name '*~' -exec rm -v -- {} \+

.PHONY: noop
noop:

################
# Application specific targets

.PHONY: build
build:
	$(complain-if-not-configured)
	$(docker_compose_command) build

.PHONY: up
up:
	$(complain-if-not-configured)
	$(docker_compose_command) up -d

.PHONY: watch
watch: watch-app

.PHONY: watch-app
watch-app:
	$(complain-if-not-configured)
	{ find app/root/usr/src/app -type f; \
	  find app/root/usr/src -maxdepth 1 -type f; } | \
	entr -p make reload-app

.PHONY: down
down:
	$(complain-if-not-configured)
	$(docker_compose_command) down

.PHONY: logs
logs:
	$(complain-if-not-configured)
	$(docker_compose_command) logs --tail=10 -f

.PHONY: reload
reload: reload-nginx reload-redis reload-app

.PHONY: reload-nginx reload-redis reload-app
reload-nginx reload-redis reload-app: reload-%:
	$(complain-if-not-configured)
	$(docker_compose_command) exec $* entrypoint.sh reload

################
# Source transformations
