# Summary

## Description

This role installs the Nginx web server along with basic configuration, which
includes:

- a `nginx.conf` file notably setting some security-related headers and a TLS
  configuration that aims at being safe enough while inclusive enough in regards
  of existing web browsers;
- a default `server` block and a `server` block specific to the server hostname,
  with a support for modular web applications in subdirectories.

## Prerequired roles

- `common`
- `tls`

# Manual steps

# Configuration parameters (ansible variables)

## Mandatory parameters

### `server_name`

The machine name of the administered server, e.g. "mycomputer".

### `domain_name`

The domain name, e.g. "mydomain.org".

## Optional parameters

None.
