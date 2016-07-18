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

# Application specific targets

.PHONY: migrate
migrate:
	$(MANAGEPY) makemigrations
	$(MANAGEPY) migrate

.PHONY: server-webpack
server-webpack:
	$(NODE) server.js

.PHONY: server-django
server-django:
	$(MANAGEPY) runserver 8888

# Source transformations
