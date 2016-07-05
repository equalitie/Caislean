# Summary

## Description

This role hardens some system defaults:

- makes every new file created by any user accessible only by the given user, by
  setting PAM's `umask` parameter to 077;
- allows only one user to connect using SSH: the user ansible uses to connect to
  the host (it is possible to specify additional users - see below);
- prevents the superuser from connecting directly via SSH, unless it is used by
  ansible to connect to the server;
- sets some `sysctl` parameters to values more advisable for security.

This role is automatically included in the `common` role.

## Prerequired roles

None.

# Manual steps

# Configuration parameters (ansible variables)

## Mandatory parameters

None.

## Optional parameters

### `ssh_additional_users`

This optional parameter must be an array of authorized users that will be
allowed to access your server using SSH. They will be added to the `AllowUsers`
directive of the SSH server configuration.

Example:

    ssh_additional_users: [kheops, timmy]
