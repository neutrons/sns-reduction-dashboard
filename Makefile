MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

# Environment Variables

ifndef SERVER_PORT
SERVER_PORT := 8888
endif

ifndef SERVER
SERVER := python -m SimpleHTTPServer $(SERVER_PORT)
endif

# Local Variables

source_files := $(wildcard src/*.html)

# Standard Targets

.PHONY: all
all:
	$(MAKE) -j 2 watcher server

.PHONY: check
check: $(source_files)
	jshint --extract=auto $^

.PHONY: check-new
check-new: $(source_files)
	jshint --extract=auto $?

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
	while true; do ls -d src/*.html | entr -d -r make check index.html; done
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
