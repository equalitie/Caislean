# Summary

## Description

This role installs and sets up LDAP Account Manager, a web interface designed
to administrate an LDAP tree.

## Prerequired roles

- `common`
- `openldap`
- `nginx`
- `php-fpm`

# Logging in

Log in at the following URL using the credentials below.

- URL: `https://server_name.domain_name/lam`
- Username: `cn=admin,dc=domain_name,dc=tld`
- Password: `ldap_admin_pass`

Example:

`server_name = caislean`
`domain_name = example.com`
`ldap_admin_pass = sekrit`

With the above settings, the correct URL, username and password would be:

- URL: `https://caislean.example.com/lam`
- Username: `cn=admin,dc=example,dc=com`
- Password: `sekrit`

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
