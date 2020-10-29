#!make
# This is a generated file. Please make sure to edit source files.
IMAGE := anskaffelser/ehftools:edge
PROJECT := $(if $(PROJECT),$(PROJECT),$(shell dirname $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))))
IDENIFIER := $(if $(IDENIFIER),$(IDENIFIER),unknown)
TITLE := $(if $(TITLE),$(TITLE),Unknown)
RELEASE := $(if $(RELEASE),$(RELEASE),Unofficial)
DOCS_FOLDER := $(if $(DOCS_FOLDER),$(DOCS_FOLDER),docs)
RULES_FOLDER := $(if $(RULES_FOLDER),$(RULES_FOLDER),rules)
RULES_IDENT := $(if $(RULES_IDENT),$(RULES_IDENT),rules)
BUILD = structure example schematron xsd rules docs scripts
.DEFAULT_GOAL = default
define fold_start
	@echo "\033[33;1m$(2)\033[0m"
endef
define skip
	@echo "\033[2;37mSkipping $(1)\033[0m"
endef
default: clean build
build: env $(BUILD)
RULE_CLEAN=$(shell (test -e $(PROJECT)/target && echo true) || echo false)
clean:
ifeq "$(RULE_CLEAN)" "true"
	$(call fold_start,clean,Removing old target folder)
	@rm -rf $(PROJECT)/target
else
	$(call skip,cleaning)
endif
init:
	@mkdir -p target
serve:
	$(call fold_start,serve,Serve serve)
	@ruby -run -e httpd target --bind-address 0.0.0.0 --port 8000
env: init
	$(call fold_start,environment,Creating environment file)
	@sh tools/ehf.sh trigger_environment
docs: init
	$(call fold_start,docs,Creating documentation)
	@ehf-docs -p . -t target/site
RULE_RULES=$(shell find $(PROJECT) -name buildconfig.xml | wc -l | xargs test "0" != && echo "true" || echo "false")
rules: init
ifeq "$(RULE_RULES)" "true"
	$(call fold_start,rules,Running vefa-validator)
	@validator build -x -t -n $(RULES_IDENT) -b $(RELEASE) -target target/validator $(PROJECT)
else
	$(call skip,rules)
endif
RULE_STRUCTURE=$(shell (test -e $(PROJECT)/project.xml && echo true) || echo false)
structure: init
ifeq "$(RULE_STRUCTURE)" "true"
	$(call fold_start,structure,Running vefa-structure)
	@structure
else
	$(call skip,structure)
endif
RULE_XSD=$(shell test -d $(PROJECT)/xsd && find $(PROJECT)/xsd -mindepth 1 -maxdepth 1 -type d | wc -l | xargs test '0' != && echo true || echo "false")
xsd: init
ifeq "$(RULE_XSD)" "true"
	$(call fold_start,xsd,Packaging XSD files)
	@sh tools/ehf.sh trigger_xsd
else
	$(call skip,xsds)
endif
RULE_SCRIPTS=$(shell test -d $(PROJECT)/scripts && find $(PROJECT)/scripts -maxdepth 1 -name '*.sh' | wc -l | xargs test "0" != && echo true || echo false)
scripts: init
ifeq "$(RULE_SCRIPTS)" "true"
	$(call fold_start,scripts,Running scripts)
	@sh tools/ehf.sh trigger_scripts
else
	$(call skip,scripts)
endif
RULE_SCHEMATRON=$(shell test -e $(PROJECT)/rules && find $(PROJECT)/rules -mindepth 2 -maxdepth 2 -name sch -type d | wc -l | xargs test "0" != && echo true || echo false)
schematron: init
ifeq "$(RULE_SCHEMATRON)" "true"
	$(call fold_start,schematron,Packaging Schematron files)
	@sh tools/ehf.sh trigger_schematron
else
	$(call skip,schematron)
endif
RULE_EXAMPLE=$(shell test -d $(PROJECT)/rules && find $(PROJECT)/rules -mindepth 2 -maxdepth 2 -name example -type d | wc -l | xargs test "0" != && echo true || echo false)
example: init
ifeq "$(RULE_EXAMPLE)" "true"
	$(call fold_start,example,Packaging example files)
	@sh tools/ehf.sh trigger_examples
else
	$(call skip,example files)
endif
docker:
	@docker run --rm -i -p 8000:8000 -u $$(id -u) -v $$(pwd):/work $(IMAGE) make
.PHONY: default build clean serve pull env docs rules structure xsd scripts schematron example
