MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

################
# Utilities

# Used for backups
date := $(shell date +%Y%m%d%H%M%S)

# Used for debugging
.PHONY: echo.%
echo.%:
	@echo $*=$($*)

################
# Environment variables

ifndef DOCKER_COMPOSE_BIN
DOCKER_COMPOSE_BIN := $(firstword $(shell which docker-compose 2>/dev/null))
endif

ifndef ENTR_BIN
ENTR_BIN := $(firstword $(shell which entr scripts/entr.bash 2>/dev/null))
endif

ifndef ENV_FILE
ENV_FILE := .env
endif

################
# .env variables

define newline


endef

ENV_VARIABLES :=
$(eval \
  $(subst @@@,$(newline),\
    $(shell ./scripts/env_vars_to_makefile.bash $(ENV_FILE))))

################
# Sanity checks and local variables

ifeq ($(DOCKER_COMPOSE_BIN),)
$(error 'docker-compose' executable not found)
endif

docker_compose_file := docker-compose.yml
ifeq ($(wildcard $(docker_compose_file)),)
$(error $(docker_compose_file) does not exist)
endif

docker_compose_command := \
	$(DOCKER_COMPOSE_BIN) -f $(docker_compose_file)

complain-if-not-configured :=
ifeq ($(CONFIGURED),false)
complain-if-not-configured := @echo "Configure the .env file"; false
endif

################
# Exported variables

export DOCKER_COMPOSE_FILE := $(docker_compose_file)
export DATE := $(date)

################
# Standard targets

.PHONY: all
all: build up logs

.PHONY: check
check: check-docker check-env

.PHONY: clean
clean:
	find . -name '*~' -print -delete

################
# Application specific targets

.PHONY: build
build:
	$(complain-if-not-configured)
	$(docker_compose_command) build

.PHONY: check-docker
check-docker:
	$(docker_compose_command) config -q

.PHONY: check-env
check-env:
	./scripts/diff_env.bash

.PHONY: up
up:
	$(complain-if-not-configured)
	$(docker_compose_command) up -d

.PHONY: watch
watch: watch-api

.PHONY: watch-api
watch-api:
	$(complain-if-not-configured)
	{ find api/root/usr/src/api -type f; \
	  find api/root/usr/src -maxdepth 1 -type f; } | \
	$(ENTR_BIN) -p make restart

.PHONY: down
down:
	$(complain-if-not-configured)
	$(docker_compose_command) down

.PHONY: logs
logs:
	$(complain-if-not-configured)
	$(docker_compose_command) logs --tail=10 -f

.PHONY: restart
restart:
	$(complain-if-not-configured)
	$(docker_compose_command) restart

.PHONY: restart-nginx restart-redis restart-api
restart-nginx restart-redis restart-api: restart-%:
	$(complain-if-not-configured)
	$(docker_compose_command) restart $*

################
# Source transformations

.env: .env.base
	touch $@
	cp $@ $@.bak
	./scripts/merge_env.bash $@.bak $< > $@
