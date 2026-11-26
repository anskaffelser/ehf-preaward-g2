#!make

IDENTIFIER = ehf-preaward-g2
RULES_IDENT = no.anskaffelser.ehf.preaward.g2
#RELEASE = 2020-10-29

build: gitsubs
init: gitsubs

gitsubs:
	git submodule update --init --recursive _source/ehf-cv

.PHONY: gitsubs

include tools/ehf.makefile
