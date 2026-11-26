#!make

IDENTIFIER = ehf-preaward-g2
RULES_IDENT = no.anskaffelser.ehf.preaward.g2
#RELEASE = 2020-10-29

build: gitsubs
init: gitsubs

gitsubs:
	@if ! git ls-files --stage -- _source/ehf-cv | grep -q '^160000 '; then \
		echo "EHF CV gitlink is missing; commit _source/ehf-cv as a submodule before building." >&2; \
		exit 1; \
	fi
	@git submodule update --init --recursive -- _source/ehf-cv

.PHONY: gitsubs

include tools/ehf.makefile
