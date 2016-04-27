# Summary

## Description

This role hardens some system defaults:

- makes every new file created by any user accessible only by the given user, by
  setting PAM's `umask` parameter to 077;
- allows only one user to connect using SSH: the user ansible uses to connect to
  the host;
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

None.
