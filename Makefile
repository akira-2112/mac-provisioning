# -*- mode: makefile; coding: utf-8-unix -*-

##############################################################################
#  Commands
##############################################################################
COMPOSE_RUN := docker compose run --rm

ANSIBLE_PLAYBOOK := ~/.nix-profile/bin/ansible-playbook
ANSIBLE_LINT := $(COMPOSE_RUN) ansible-lint
SHELLCHECK := $(COMPOSE_RUN) shellcheck
SHFMT := $(COMPOSE_RUN) shfmt

##############################################################################
#  Rules
##############################################################################
.PHONY: all
all: install-ansible install-homebrew
	$(ANSIBLE_PLAYBOOK) setup.yml

.PHONY: install-ansible
install-ansible: install-nix ## Install ansible
	test -x $(ANSIBLE_PLAYBOOK) || nix profile install nixpkgs#ansible

.PHONY: install-nix
install-nix: ## Install nix
	./install_nix.sh

.PHONY: install-homebrew
install-homebrew: ## Install homebrew
	./install_homebrew.sh

.PHONY: lint-ansible
lint-ansible:
	$(ANSIBLE_LINT)

.PHONY: format-ansible
format-ansible:
	$(ANSIBLE_LINT) --write

.PHONY: lint-shellscript
lint-shellscript:
	$(SHELLCHECK) *.sh

.PHONY: format-shellscript
format-shellscript:
	$(SHFMT) *.sh

.DEFAULT_GOAL := help
.PHONY: help
help: ## Print rules (https://postd.cc/auto-documented-makefile/)
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
