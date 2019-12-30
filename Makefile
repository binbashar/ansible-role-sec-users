.PHONY: help
SHELL := /bin/bash

ANSIBLE_GALAXY_ROLE_NAME := binbash_inc.ansible_role_users
PY_MOLECULE_VER := 2.22

define OS_VER_LIST
"ubuntu1804" \
"ubuntu1604" \
"debian10" \
"debian9" \
"debian8"
endef

help:
	@echo 'Available Commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2}'

#==============================================================#
# MOLECULE: ANSIBLE ROLE TESTS                                 #
#==============================================================#
init: ## Install required ansible roles
	pip install --user -I molecule[docker]==${PY_MOLECULE_VER}

test-molecule-galaxy: ## Run playbook tests w/ molecule pulling role from ansible galaxy
	mkdir -p molecule/default/roles
	ansible-galaxy install ${ANSIBLE_GALAXY_ROLE_NAME} -p molecule/default/roles -f

	OS_VER=(${OS_VER_LIST});\
    for i in "$${OS_VER[@]}"; do\
        echo -------------------------------;\
        echo TESTING MODULE ON: $$i;\
        echo -------------------------------;\
    	docker pull geerlingguy/docker-$$i-ansible;\
		if [ "$$i" != "debian8" ]; then\
			MOLECULE_DISTRO=$$i molecule test;\
		else\
	    	echo "Last testing stage";\
	    	MOLECULE_DISTRO=$$i molecule test || rm -rf molecule/default/roles;\
		fi;\
        echo -------------------------------;\
        echo "DONE";\
        echo "";\
	done;

test-molecule-local: ## Run playbook tests w/ molecule using the local code
	mkdir -p molecule/default/roles/${ANSIBLE_GALAXY_ROLE_NAME}
	cd .. && rsync -Rr --exclude './ansible-role-users/molecule' ./ansible-role-users/ ./ansible-role-users/molecule/default/roles/${ANSIBLE_GALAXY_ROLE_NAME}/ \

	OS_VER=(${OS_VER_LIST});\
    for i in "$${OS_VER[@]}"; do\
        echo -------------------------------;\
        echo TESTING MODULE ON: $$i;\
        echo -------------------------------;\
    	docker pull geerlingguy/docker-$$i-ansible;\
		if [ "$$i" != "debian8" ]; then\
			echo "## Starting testing stages ##";\
			MOLECULE_DISTRO=$$i molecule test;\
		else\
			echo "## Last testing stage ##";\
	    	MOLECULE_DISTRO=$$i molecule test || rm -rf molecule/default/roles;\
		fi;\
        echo -------------------------------;\
        echo "DONE";\
        echo "";\
	done;

#==============================================================#
# CIRCLECI 													   #
#==============================================================#
circleci-validate-config: ## Validate A CircleCI Config (https://circleci.com/docs/2.0/local-cli/)
	circleci config validate .circleci/config.yml