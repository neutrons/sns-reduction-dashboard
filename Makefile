MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

# Environment variables

ifndef PYTHON
PYTHON := python3
endif

ifndef MANAGEPY
MANAGEPY := $(PYTHON) manage.py
endif

ifndef NODE
NODE := $(firstword $(shell which node nodejs 2>/dev/null))
endif

# Local variables

# Standard targets

.PHONY: all
all:
	+$(MAKE) -j 2 server-webpack server-django

.PHONY: depend
depend: depend-npm depend-python

.PHONY: clean
clean:
	rm -f -- webpack-assets.json webpack-stats.json

# Application specific targets

.PHONY: depend-npm
depend-npm:
	npm install

.PHONY: depend-python
depend-python:
ifeq ($(VIRTUAL_ENV),)
	@echo 'No virtual environment detected.'
	@read -p 'Are you sure you wish to continue? (yes/No)' && [ "$$REPLY" = yes ]
endif
	$(PYTHON) -m pip install -r requirements.txt

.PHONY: delete-migrations
delete-migrations:
	for f in job catalog core reduction; do \
		rm -rf ./$$f/migrations/* && \
		mkdir -p ./$$f/migrations && \
		touch ./$$f/migrations/__init__.py || \
		exit 1; \
	done

.PHONY: migrate
migrate:
	$(MANAGEPY) makemigrations
	$(MANAGEPY) migrate

.PHONY: server-webpack
server-webpack:
	$(NODE) server.js || echo 'Error: Node'

.PHONY: server-django
server-django:
	$(MANAGEPY) runserver 8888 || echo 'Error: Django'

# Source transformations
