<div align="center">
    <img src="./%40doc/figures/binbash-logo.png" 
    alt="binbash" width="250"/>
</div>
<div align="right">
  <img src="./%40doc/figures/binbash-leverage-ansible-logo.png"
  alt="leverage" width="130"/>
</div>

# Ansible Role: binbash_inc.ansible_role_users

Ansible user management role based on the official **users module** (https://docs.ansible.com/ansible/2.5/modules/user_module.html)

## Requirements

None.

### Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

List of users to be created

```
users_list_creation: []
```

List of users to be deleted (`users_delete` flag must be set to `True` in order to be effectively delete de users in the list.
**NOTE:** Users must not be present in the `users_list_creation` var for functioning consistency.
```
users_list_deletion: []
users_delete: false
```

Nested list where each item  it's composed by [`username_here`,`absolute_path_to_user_home_here`]
```
users_nested_list_ssh_key_path_with_user: [['user1','/home/user1']]
```

## Dependencies

None.

### Example Playbook

With user creation, deletion and ssh key generation for **jenkins** user
```
- role: binbash_inc.ansible_role_users
  users_list_creation_var: ['username1','username4','username5']
  users_delete_var: True
  users_list_deletion_var: ['username2','username3']
  users_nested_list_ssh_key_path_with_user_var: [['jenkins','/var/lib/jenkins']]
```

With user creation and ssh key generation for **jenkins**
```
- role: binbash_inc.ansible_role_users
  users_list_creation_var: ['username1','username4','username5']
  users_delete_var: false
  users_list_deletion_var: []
  users_nested_list_ssh_key_path_with_user_var: [['jenkins','/var/lib/jenkins']]
```

---
## Binbash Leverage | DevOps Automation Code Library Integration

In order to get the full automated potential of the
[Binbash Leverage DevOps Automation Code Library](https://leverage.binbash.com.ar/how-it-works/code-library/code-library/)  
you should initialize all the necessary helper **Makefiles**.

#### How?
You must execute the `make init-makefiles` command  at the root context

```shell
╭─delivery at delivery-ops
╰─⠠⠵ make
Available Commands:
 - init-makefiles     initialize makefiles

```

### Why?
You'll get all the necessary commands to automatically operate this module via a dockerized approach,
example shown below

```shell
╭─delivery at delivery-ops
╰─⠠⠵ make
Available Commands:
 - ansible-galaxy-import-role  ## Run playbook tests w/ molecule using the local code
 - init                ## Install required ansible roles
 - test-ansible-lint   ## Ansible lint
 - test-molecule-galaxy  ## Run playbook tests w/ molecule pulling role from ansible galaxy
 - test-molecule-local  ## Run playbook tests w/ molecule using the local code
 - circleci-validate-config  ## Validate A CircleCI Config (https
 - changelog-init      ## git-chglog (https
 - changelog-major     ## git-chglog generation for major release
 - changelog-minor     ## git-chglog generation for minor release
 - changelog-patch     ## git-chglog generation for path release
 - release-major       ## releasing major (eg
 - release-major-with-changelog-circleci  ## make changelog-major && git add && git commit && make release-major
 - release-major-with-changelog  ## make changelog-major && git add && git commit && make release-major
 - release-minor       ## releasing minor (eg
 - release-minor-with-changelog-circleci  ## make changelog-minor && git add && git commit && make release-minor
 - release-minor-with-changelog  ## make changelog-minor && git add && git commit && make release-minor
 - release-patch       ## releasing patch (eg
 - release-patch-with-changelog-circleci  ## make changelog-patch && git add && git commit && make release-patch
 - release-patch-with-changelog  ## make changelog-patch && git add && git commit && make release-patch
 - init-makefiles      ## initialize makefiles
```

```shell
╭─delivery at delivery-ops
╰─⠠⠵ make test-molecule-local 
...
-------------------------------
TESTING MODULE ON: ubuntu1804
-------------------------------
Using default tag: latest
latest: Pulling from geerlingguy/docker-ubuntu1804-ansible
Digest: sha256:1b47cbb66e819170fd3afee98db55176bc13cd12fabdbcf0183aff2582dc0254
Status: Image is up to date for geerlingguy/docker-ubuntu1804-ansible:latest
docker.io/geerlingguy/docker-ubuntu1804-ansible:latest
## Starting testing stages ##
--> Test matrix
    
└── default
    ├── dependency
    ├── lint
    ├── cleanup
    ├── destroy
    ├── syntax
    ├── create
    ├── prepare
    ├── converge
    ├── idempotence
    ├── side_effect
    ├── verify
    ├── cleanup
    └── destroy
    
--> Scenario: 'default'
...
    
    PLAY [Destroy] *****************************************************************
    
    TASK [Destroy molecule instance(s)] ********************************************
    changed: [localhost] => (item=instance)
    
    TASK [Wait for instance(s) deletion to complete] *******************************
    FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
    changed: [localhost] => (item=None)
    changed: [localhost]
    
    TASK [Delete docker network(s)] ************************************************
    
    PLAY RECAP *********************************************************************
    localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
    
--> Pruning extra files from scenario ephemeral directory
-------------------------------
DONE

-------------------------------
TESTING MODULE ON: ubuntu1604
-------------------------------
```

## License

MIT / BSD

# Release Management
### CircleCi PR auto-release job

<div align="left">
  <img src="./%40doc/figures/circleci-logo.png" alt="circleci" width="130"/>
</div>

- [**pipeline-job**](https://app.circleci.com/pipelines/github/binbashar/ansible-role-users) (**NOTE:** Will only run after merged PR)
- [**releases**](https://github.com/binbashar/ansible-role-users/releases) 
- [**changelog**](https://github.com/binbashar/ansible-role-users/blob/master/CHANGELOG.md) 
