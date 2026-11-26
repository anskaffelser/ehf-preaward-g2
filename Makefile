#!make

IDENTIFIER = ehf-preaward-g2
RULES_IDENT = no.anskaffelser.ehf.preaward.g2
#RELEASE = 2020-10-29

build: gitsubs
init: gitsubs

gitsubs:
	@if ! git ls-files --stage -- _source/ehf-cv | grep -q '^160000 '; then \
		git submodule add --force -b master https://github.com/anskaffelser/ehf-cv.git _source/ehf-cv || exit $$?; \
	fi
	@git submodule update --init --recursive -- _source/ehf-cv
	@git submodule status
	@git status --short

.PHONY: gitsubs

include tools/ehf.makefile
