MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

# Environment Variables

ifndef PYTHON
PYTHON := $(firstword $(shell which python3.5 python3 python 2>/dev/null))
endif
export PYTHON

ifndef SERVER_FLAGS
SERVER_FLAGS := --assets=webpack-assets.json --port=8888 --status=webpack-stats.json
endif

ifndef ENTR
ENTR := $(firstword $(shell which entr scripts/entr.bash 2>/dev/null))
endif
export ENTR

ifndef JSHINT
JSHINT := $(shell which jshint)
endif
export JSHINT

ifndef NODE
NODE := $(firstword $(shell which node nodejs 2>/dev/null))
endif
export NODE

# Local Variables

source_files := $(wildcard src/*.html)

# Standard Targets

.PHONY: all
all:
	+$(MAKE) -j 2 watcher server

.PHONY: no-watch
no-watch:
	+$(MAKE) -j 2 watcher-no-watch server-no-watch

.PHONY: depend
depend: depend-npm depend-python

.PHONY: depend-npm
depend-npm:
	npm install

.PHONY: depend-python
depend-python:
ifeq ($(VIRTUAL_ENV),)
	@echo 'No virtual environment detected.'
	@read -p 'Are you sure you wish to continue? (yes/No) ' && [ "$$REPLY" = "yes" ]
endif
	$(PYTHON) -m pip install -r requirements.txt

.PHONY: check
check: $(source_files)
ifneq ($(JSHINT),)
	$(JSHINT) --extract=auto $^
endif

.PHONY: check-new
check-new: $(source_files)
ifneq ($(JSHINT),)
	$(JSHINT) --extract=auto $?
endif

.PHONY: check-self
check-self:
	@[[ "$(PYTHON)" ]] || echo "PYTHON: Empty variable"
	@[[ "$(SERVER_PORT)" ]] || echo "SERVER_PORT: Empty variable"
	@[[ "$(JSHINT)" ]] || echo "JSHINT: Empty variable, no tests will run."
	@[[ "$(ENTR)" ]] || echo "ENTR: Empty variable, watcher will not work"
	@[[ "$(SERVER)" ]] || echo "SERVER: Empty variable, server will not work"

.PHONY: clean
clean:
	rm -rf -- dist webpack-assets.json webpack-stats.json

# Helper targets

.PHONY: server-no-watch
server-no-watch:
	$(PYTHON) server.py $(SERVER_FLAGS)

.PHONY: server
server:
	trap exit INT TERM; \
	while true; do \
		ls server.py | \
		$(ENTR) -r $(MAKE) server-no-watch; \
	done

.PHONY: watcher-no-watch
watcher-no-watch:
	$(NODE) server.js

.PHONY: watcher
watcher:
	trap exit INT TERM; \
	while true; do \
		ls server.js | \
		$(ENTR) -r $(MAKE) watcher-no-watch; \
	done
