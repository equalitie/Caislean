# Summary

## Description

## Prerequired roles

# Manual steps

# Configuration parameters (ansible variables)

## Mandatory parameters

### `openvpn_auth_mech`

Authentication mechanism for OpenVPN. Can be:

- `tls` to authenticate clients with their TLS certificates;
- `ldap` to authenticate clients with a login and password, against the
  locally-running OpenLDAP instance;
- `both` to perform both authentication, in which case a connecting client needs
  both a valid TLS certificate and valid credentials to connect.

### `server_name`

The machine name of the administered server, e.g. "mycomputer".

### `domain_name`

The domain name, e.g. "mydomain.org".

## Optional parameters

### `auth_use_samba`

Can be set to either `true` or `false` (default). Defines whether LDAP
authentication should check credentials against the `samba` organisational unit
in the LDAP tree rather than the `mail` one. This option is only useful if you
are also using the `samba` role.

