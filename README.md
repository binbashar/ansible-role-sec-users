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

## License

MIT / BSD