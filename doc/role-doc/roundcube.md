# Summary

## Description

This role installs the Roundcube package from the Debian repositories, and
installs a Nginx configuration file with a `location` block to make the
`/webmail/` HTTP directory point to the Roundcube web application. A dedicated
`roundcube` user is created and allows to isolate the PHP process from other web
applications.

Users are identified against the locally running Dovecot server, through IMAP.

## Prerequired roles

- `base-packages`
- `base-config`
- `tls`
- `nginx`
- `php-fpm`
- `openldap`
- `virtualmail`

# Manual steps

# Configuration parameters (ansible variables)

## Mandatory parameters

### `server_name`

The machine name of the administered server, e.g. "mycomputer".

### `domain_name`

The domain name, e.g. "mydomain.org".

## Optional parameters

None.
