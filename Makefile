MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

ifndef SERVER
SERVER := python -m SimpleHTTPServer 8888
endif

all: server

.PHONY: server
server: index.html
	$(SERVER)

index.html: .bootstrap.unzipped

.bootstrap.unzipped: bootstrap.zip
	unzip -o -d bootstrap/ $<
	touch $@

.PHONY: clean
clean:
	rm -rf -- bootstrap/ .bootstrap.unzipped
