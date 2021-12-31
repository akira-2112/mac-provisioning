
PIPX := $(HOME)/.local/bin/pipx
ANSIBLE_PLAYBOOK := $(HOME)/.local/bin/ansible-playbook
ANSIBLE_LINT := $(HOME)/.local/bin/ansible-lint

HOMEBREW_X64 := /usr/local/bin/brew
HOMEBREW_ARM := /opt/homebrew/bin/brew

.PHONY: all
all:

.PHONY: install
install: ensure_ansible ensure_ansible_lint ensure_homebrew
	$(ANSIBLE_PLAYBOOK) setup.yml

.PHONY: ensure_ansible
ensure_ansible: $(ANSIBLE_PLAYBOOK)

.PHONY: ensure_ansible_lint
ensure_ansible_lint: $(ANSIBLE_LINT)

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

.PHONY: ensure_homebrew
ensure_homebrew: $(HOMEBREW_X64) $(HOMEBREW_ARM)

$(HOMEBREW_X64):
	arch -x86_64 /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

$(HOMEBREW_ARM):
	arch -arm64 /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
