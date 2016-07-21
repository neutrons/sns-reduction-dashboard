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
PYTHON := python3
endif

ifndef MANAGEPY
MANAGEPY := $(PYTHON) manage.py
endif

ifndef NODE
NODE := $(firstword $(shell which node nodejs 2>/dev/null))
endif

ifndef JSHINT
JSHINT := $(firstword $(shell which jshint node_modules/.bin/jshint 2>/dev/null))
endif

# Sanity checks and local variables

valid_env := local dev stage prod
ifeq ($(filter $(ENV),$(valid_env)),)
$(error $$ENV ('$(ENV)') should be one of $(valid_env))
endif

env_file := config/env/$(ENV).env
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

# Exported variables

export DJANGO_SETTINGS_MODULE := $(settings_module)
export DJANGO_WSGI_APPLICATION := $(wsgi_module)
export ENV_FILE := $(env_file)

# Standard targets

.PHONY: all
all:
	+$(MAKE) -j 2 server-webpack server-django

.PHONY: depend
depend: depend-javascript depend-python

.PHONY: check
check: check-python check-javascript

.PHONY: clean
clean:
	rm -f -- webpack-assets.json webpack-stats.json

# Application specific targets

.PHONY: depend-javascript
depend-javascript:
	npm install

.PHONY: depend-python
depend-python:
ifeq ($(VIRTUAL_ENV),)
	@echo 'No virtual environment detected.'
	@read -p 'Are you sure you wish to continue? (yes/No)' && [ "$$REPLY" = yes ]
endif
	$(PYTHON) -m pip install -r $(requirements_file)

.PHONY: delete-migrations
delete-migrations:
	for f in job catalog core reduction; do \
		rm -rf ./sns_dashboard/$$f/migrations/* && \
		mkdir -p ./sns_dashboard/$$f/migrations && \
		touch ./sns_dashboard/$$f/migrations/__init__.py || \
		exit 1; \
	done

.PHONY: migrate
migrate:
	$(MANAGEPY) makemigrations
	$(MANAGEPY) migrate

.PHONY: check-python
check-python:
	$(MANAGEPY) test

.PHONY: check-javascript
check-javascript:
	$(JSHINT) --config config/jshint.json src

.PHONY: server-webpack
server-webpack:
	$(NODE) scripts/server.js

.PHONY: server-django
server-django:
	$(MANAGEPY) runserver 8888

# Source transformations
