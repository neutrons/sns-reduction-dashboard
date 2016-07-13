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

# Local Variables

source_files := $(wildcard src/*.html)

# Standard Targets

.PHONY: all
all:
	$(MAKE) -j 2 watcher server

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
	rm -rf -- bootstrap/ .bootstrap.unzipped

# Helper targets

.PHONY: server
server:
	trap exit INT TERM; \
	while true; do \
		ls server.py | \
		$(ENTR) -r $(PYTHON) server.py $(SERVER_FLAGS); \
	done

.PHONY: watcher
watcher:
	trap exit INT TERM; \
	while true; do \
		ls server.js | \
		$(ENTR) -r node server.js; \
	done
