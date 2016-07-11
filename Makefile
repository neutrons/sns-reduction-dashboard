MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

# Environment Variables

ifndef PYTHON
PYTHON := $(firstword $(shell which python2.7 python2 python 2>/dev/null))
endif
export PYTHON

ifndef SERVER_PORT
SERVER_PORT := 8888
endif
export SERVER_PORT

ifndef SERVER
ifneq ($(SERVER_PORT),)
ifneq ($(PYTHON),)
SERVER := $(PYTHON) -m SimpleHTTPServer $(SERVER_PORT)
endif
endif
endif
export SERVER

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
server: index.html
	$(SERVER)

.PHONY: watcher
watcher:
	trap exit INT TERM; \
	while true; do ls -d src/*.html | $(ENTR) -d $(MAKE) check index.html; done
	rm index.html
	false

.PHONY: renumber
renumber:
	mkdir src2
	for f in src/*.html; do \
		git ls-files "$$f" --error-unmatch || exit 1; \
	done
	i=0; \
	for f in src/*.html; do \
		x=$$(printf "src2/%03d-$${f#*-}" "$$i"); \
		git mv "$$f" "$$x"; \
		i=$$((i+5)); \
	done
	rm -r src
	git mv src2 src

# Actual source transformations

index.html: $(source_files) .bootstrap.unzipped
	find . -name '*~' -exec rm {} \+
	cat $(filter %.html,$^) > $@

.bootstrap.unzipped: bootstrap.zip
	unzip -o -d bootstrap/ $<
	touch $@

# Testing

out.png:
	./node_modules/.bin/phantomjs scripts/load-page.js 'http://localhost:8080/#!/catalog' $@ -w 1280 -h 900
