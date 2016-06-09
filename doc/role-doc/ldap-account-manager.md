# Summary

## Description

This role installs and setups LDAP Account Manager, a web interface designed to
fully administrate a LDAP tree.

This role is currently broken.

## Prerequired roles

- `base-packages`
- `openldap`
- `nginx`
- `php-fpm`

# Manual steps

# Configuration parameters (ansible variables)

## Mandatory parameters

### `server_name`

The machine name of the administered server, e.g. "mycomputer".

### `domain_name`

The domain name, e.g. "mydomain.org".

### `ldap_admin_pass`

The LDAP administrator password.

## Optional parameters

None.
