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

# Local variables

# Standard targets

.PHONY: all
all:

# Application specific targets

# Source transformations
