# Summary

## Description

This role installs the Samba file sharing server, configured in the standalone
server mode.

It aims at allowing users to store files within their home directory as well as
to use shared network drives within groups of users. Users have to first connect
to the VPN in order to connect to the Samba shares.

Authenticating the users is done through LDAP. However, unlike for other
services (Dovecot, Prosody, Owncloud, etc.), users are not looked up within the
`mail` organisational unit (OU), but a dedicated tree is created under the
`samba` OU. In addition, in order for Samba to properly set ownership on files
created by users, the LDAP users must be recognized as valid Unix users by the
system. To this purpose, the role also installs `nscd` and `nslcd` as well as a
properly configured `/etc/nsswitch.conf`. By default, all these users have a
shell set to `/bin/false`.

Note: this is a work in progress, as currently the configurations lack a lot of
flexibility, and the integration with the rest of the LDAP system is not
interoprable with other roles excepted OpenVPN.

## Prerequired roles

- `base-packages`
- `base-config`
- `openldap`

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

### `samba_shares`

Defines a list of shares shown by Samba to clients. For each share, several
parameters are needed:

- `name`: name of the shared drive as it will appear to clients;
- `path`: the corresponding directory on the server;
- `valid_users`: list of valid users, following the syntax required by Samba's
  `valid users` parameter
- `caption` (defaults to `name`): comment of the shared drive;
- `create_mask` (defaults to "0600"): default permissions for newly created
  files in the given share
- `directory_mask` (defaults to "0700"): default permissions for newly created
  directories in the given share

Example:

    samba_shares:
      - name: Documents
        caption: Company documents
        path: /home/docs
        valid_users: "@Staff"
        create_mask: "0660"
        directory_mask: "0770"
      - name: Finance
        caption: Financial documents
	path: /home/finance
	valid_users: "@Finance"
	create_mask: "0660"
	directory_mask: "0770"
