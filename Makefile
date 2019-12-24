.PHONY: help
SHELL := /bin/bash

PY_MOLECULE_VER := 2.22

help:
	@echo 'Available Commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2}'

init: ## Install required ansible roles
	pip install --user -I molecule[docker]==${PY_MOLECULE_VER}

test-molecule: ## Run playbook tests w/ molecule
	mkdir -p molecule/default/roles
	ansible-galaxy install binbash_inc.ansible_role_users -p molecule/default/roles -f
	molecule test || rm -rf molecule/default/roles