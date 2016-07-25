MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

# Environment variables

ifndef ENV
ENV :=
endif

ifndef PYTHON
PYTHON := $(shell which python3 2>/dev/null)
endif

ifndef MANAGEPY
MANAGEPY := $(PYTHON) manage.py
endif

ifndef NODE
NODE := $(firstword $(shell which node nodejs 2>/dev/null))
endif

ifndef NPM
NPM := $(shell which npm 2>/dev/null)
endif

ifndef JSHINT
JSHINT := $(firstword $(shell which jshint node_modules/.bin/jshint 2>/dev/null))
endif

ifndef DOCKER
DOCKER := $(shell which docker 2>/dev/null)
endif

# Sanity checks and local variables

ifeq ($(PYTHON),)
$(error Python executable not found)
endif

ifeq ($(NODE),)
$(error Node executable not found)
endif

ifeq ($(NPM),)
$(error NPM executable not found)
endif

ifeq ($(DOCKER),)
$(error Docker executable not found)
endif

valid_env := local dev stage prod
ifeq ($(filter $(ENV),$(valid_env)),)
$(error $$ENV ('$(ENV)') should be one of $(valid_env))
endif

env_file := config/env/$(ENV).env
$(shell test -e $(env_file) || cp $(env_file:=.base) $(env_file))
ifeq ($(wildcard $(env_file)),)
$(warn $(env_file) does not exist)
endif

settings_file := config/settings/$(ENV).py
ifeq ($(wildcard $(settings_file)),)
$(error $(settings_file) does not exist)
endif

settings_module := $(subst /,.,$(settings_file:.py=))

wsgi_file := config/wsgi/$(ENV).py
ifeq ($(wildcard $(wsgi_file)),)
$(error $(wsgi_file) does not exist)
endif

wsgi_module := $(subst /,.,$(wsgi_file:.py=))

requirements_file := config/requirements/$(ENV).txt
ifeq ($(wildcard $(requirements_file)),)
$(error $(requirements_file) does not exist)
endif

managepy := $(PYTHON) manage.py

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
  var=$${line%%=*}; \
  value=$${line#*=}; \
  echo "define $$var@@@$$value@@@endef@@@export $$var@@@"; \
  done <$(env_file) \
)))

# Exported variables

export DJANGO_SETTINGS_MODULE := $(settings_module)
export DJANGO_WSGI_APPLICATION := $(wsgi_module)
export ENV_FILE := $(env_file)
export REDIS_TAG := 'dashboard/redis:1.0'
export POSTGRES_TAG := 'dashboard/postgres:1.0'
export APP_TAG := 'dashboard/app:1.0'

# Standard targets

.PHONY: build
build:
	docker-compose build

.PHONY: up
up:
	docker-compose up

.PHONY: all
all:
	+$(MAKE) -j 4 server-webpack server-django server-redis server-postgres

.PHONY: depend
depend: depend-javascript depend-python depend-redis depend-postgres

.PHONY: check
check: check-python check-javascript

.PHONY: clean
clean:
	rm -f -- webpack-assets.json webpack-stats.json

# Application specific targets

.PHONY: depend-javascript
depend-javascript:
	$(NPM) install

.PHONY: depend-python
depend-python:
ifeq ($(VIRTUAL_ENV),)
	@echo 'No virtual environment detected.'
	@read -p 'continue? (yes/No)' && [ "$$REPLY" = yes ]
endif
	$(PYTHON) -m pip install -r $(requirements_file)

depend-redis:
	$(DOCKER) build -t $(REDIS_TAG) config/redis

depend-postgres:
	$(DOCKER) build -t $(POSTGRES_TAG) config/postgres

.PHONY: delete-migrations
delete-migrations:
	for f in catalog job reduction; do \
		rm -rf ./sns_dashboard/$$f/migrations/* && \
		mkdir -p ./sns_dashboard/$$f/migrations && \
		touch ./sns_dashboard/$$f/migrations/__init__.py || \
		exit 1; \
	done

.PHONY: migrate
migrate:
	$(managepy) makemigrations
	$(managepy) migrate

.PHONY: check-python
check-python:
	$(managepy) test

.PHONY: check-javascript
check-javascript:
	$(JSHINT) --config config/jshint.json src

.PHONY: server-webpack
server-webpack:
	$(NODE) scripts/server.js

.PHONY: server-django
server-django: migrate
	$(managepy) runserver 8888

.PHONY: server-redis
server-redis:
	$(DOCKER) run -p '6379:6379' $(REDIS_TAG) | tail -n +19

server-postgres:
	@mkdir -p pgdata
	$(DOCKER) run -p '5434:5432' -e POSTGRES_PASSWORD -e DATABASE_URL -v "$$(pwd)/pgdata:/var/lib/postgresql/data" $(POSTGRES_TAG)

# Source transformations
