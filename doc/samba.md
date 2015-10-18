# Summary

## Description

## Prerequired roles

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
