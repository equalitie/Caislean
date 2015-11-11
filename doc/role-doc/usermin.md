# Summary

## Description

This role installs Usermin, a web interface part of the
[Webmin](http://www.webmin.com) suite, which allows system users to log into
their system account through a web interface and make changes to their account,
such as changing password, changing their real name, etc.

The role installs the proper Nginx configuration file with a `location` block,
that acts as a local reverse proxy, as Usermin provides its own HTTP server
written in PERL.

Once installed, the Usermin instance is available at the `/usermin/` HTTP
subdirectory. It logs users in against Unix accounts, meaning that this can me
used in conjunction with the Samba role and associated user database.

Note: this is a work in progress, and the Nginx configuration file currently
severely restricts the requests to only the password changing page, because
Usermin otherwise allows by default a number of operations that are normally not
available to standard users, as it runs with `root` priviledges.

## Prerequired roles

- `common`
- `tls`
- `nginx`

# Manual steps

# Configuration parameters (ansible variables)

## Mandatory parameters

### `server_name`

The machine name of the administered server, e.g. "mycomputer".

### `domain_name`

The domain name, e.g. "mydomain.org".

## Optional parameters

None.
