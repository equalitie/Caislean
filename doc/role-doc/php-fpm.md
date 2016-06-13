# Summary

## Description

This role sets up the basic installation of the `php-fpm` package. In
particular, it installs a version of `php.ini` with security restrictions and
prepares a directory that will welcome temporary session files owned by
different users depending on the PHP process that is managing them.

## Prerequired roles

- `base-packages`
- `base-config`
- `tls`
- `nginx`

# Manual steps

# Configuration parameters (ansible variables)

## Mandatory parameters

None.

## Optional parameters

None.
