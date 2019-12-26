.PHONY: help
SHELL := /bin/bash

ANSIBLE_GALAXY_ROLE_NAME := binbash_inc.ansible_role_users
PY_MOLECULE_VER := 2.22

help:
	@echo 'Available Commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2}'

init: ## Install required ansible roles
	pip install --user -I molecule[docker]==${PY_MOLECULE_VER}

test-molecule-galaxy: ## Run playbook tests w/ molecule pulling role from ansible galaxy
	mkdir -p molecule/default/roles
	ansible-galaxy install ${ANSIBLE_GALAXY_ROLE_NAME} -p molecule/default/roles -f
	molecule test || rm -rf molecule/default/roles

test-molecule-local: ## Run playbook tests w/ molecule using the local code
	mkdir -p molecule/default/roles/${ANSIBLE_GALAXY_ROLE_NAME}
	cd .. && rsync -Rr --exclude './ansible-role-users/molecule' ./ansible-role-users/ ./ansible-role-users/molecule/default/roles/${ANSIBLE_GALAXY_ROLE_NAME}/
	#cd .. && rsync -Rr --exclude './ansible-role-users/molecule' ./ansible-role-users/ ./ansible-role-users/molecule/default/roles/${ANSIBLE_GALAXY_ROLE_NAME}/
	molecule test || rm -rf molecule/default/roles

#==============================================================#
# CIRCLECI 													                           #
#==============================================================#
circleci-validate-config: ## Validate A CircleCI Config (https://circleci.com/docs/2.0/local-cli/)
	circleci config validate .circleci/config.yml