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
make-env = envsubst '$(addprefix $$,$(ENV_VARIABLES))' < $< > $@

# Used to load specific .env files
load-env = set -o allexport && unset $(ENV_VARIABLES) && source $< && set +o allexport

################
# Environment variables

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

################
# Exported variables

export DATE := $(date)

################
# Includes

include api/Makefile
include frontend/Makefile

################
# Standard targets

.PHONY: all
all:

.PHONY: run
run:
	+$(MAKE) -j 1 \
		api/run

.PHONY: depend
depend: api/depend

.PHONY: check
check:
	./scripts/diff_env.bash

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
	./scripts/merge_env.bash $@.bak $< > $@
