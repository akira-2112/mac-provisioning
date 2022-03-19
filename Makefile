# -*- mode: makefile; coding: utf-8-unix -*-

##############################################################################
#  Variables
##############################################################################
PIPX := $(HOME)/.local/bin/pipx
ANSIBLE_PLAYBOOK := $(HOME)/.local/bin/ansible-playbook
ANSIBLE_LINT := $(HOME)/.local/bin/ansible-lint

HOMEBREW := /opt/homebrew/bin/brew


##############################################################################
#  Rules
##############################################################################
.PHONY: all
all: install

.PHONY: install
install: $(ANSIBLE_PLAYBOOK) $(ANSIBLE_LINT) $(HOMEBREW)
	$(ANSIBLE_PLAYBOOK) setup.yml

$(ANSIBLE_PLAYBOOK): $(PIPX)
	$(PIPX) install ansible-base
	$(PIPX) inject ansible-base ansible

$(ANSIBLE_LINT): $(PIPX)
	$(PIPX) install ansible-lint
	$(PIPX) inject ansible-lint ansible

$(PIPX):
	python3 -m pip install --user pipx
	python3 -m pipx install pipx
	$(PIPX) ensurepath

$(HOMEBREW):
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
