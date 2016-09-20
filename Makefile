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

# Used to make specific .env files
make-env = ./scripts/env.bash subst < $< > $@

# Used to load specific .env files
load-env = set -o allexport && unset $(ENV_VARIABLES) && source $< && set +o allexport

################
# Environment variables

ifndef ENTR_BIN
ENTR_BIN := $(firstword $(shell which entr scripts/entr.bash 2>/dev/null))
endif

################
# Sanity checks and local variables

################
# Exported variables

export DATE := $(date)

################
# Includes

-include .env.makefile
include api/Makefile
include frontend/Makefile
include nginx/Makefile

################
# Standard targets

.PHONY: all
all:

.PHONY: run
run:
	+$(MAKE) -j 3 \
		api/run \
		nginx/run \
		frontend/run

.PHONY: depend
depend: api/depend

.PHONY: check
check:
	./scripts/env.bash diff

.PHONY: clean
clean:
	find . -name '*~' -print -delete

################
# Application specific targets

################
# Source transformations

.env: .env.base
	touch $@
	cp $@ $@.bak
	./scripts/env.bash merge $@.bak $< > $@

.env.makefile: .env
	./scripts/env.bash to-makefile > $@
