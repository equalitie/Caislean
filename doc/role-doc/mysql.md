# Summary

## Description

This role installs MySQL server and client as well as the `php5-mysqlnd`
package. It is required by other roles such as `owncloud` or `wordpress`, that
need a MySQL server to run.

## Prerequired roles

- `base-packages`
- `base-config`

# Manual steps

# Configuration parameters (ansible variables)

## Mandatory parameters

### `mysql_root_password`

`root` user password for MySQL installation.

## Optional parameters

None.
