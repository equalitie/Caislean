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

- `base-packages`
- `base-config`
- `tls`

# Manual steps

# Configuration parameters (ansible variables)

## Mandatory parameters

### `server_name`

The machine name of the administered server, e.g. "mycomputer".

### `domain_name`

The domain name, e.g. "mydomain.org".

### `websites`

Default: `[ name:` _server name_`.`_domain name_ `]`

A set of host names that your web server will serve content for. There can be
any number of names, but the default entry is mandatory, as otherwise this or
other roles will fail. The parameter `name` has to appear explicitly.

The role creates a folder `/var/www/<name>/` for every entry, and static content
in each of these directories will be served by nginx when your web server is
accessed with the corresponding host name. A folder `/etc/nginx/include/<name>/`
is also created for each entry, in which additional nginx configuration files
can be placed (for example to enable TLS for the given hostname or to set up a
PHP-enabled application in a specific subfolder).

A number of reverse proxies can be optionally configured for each host name by
specifying the parameter `reverse_proxy`, inside which the mandatory parameter
`target` must be set to the remote URL to proxy to and the optional parameter
`location` must be set to the local path where the proxying will be done.

Example:

    websites:
      - name: "{{server_name}}.{{domain_name}}"
      - name: www.otherdomain.com
      - name: frontend.thirddomain.eu
        reverse_proxy:
	  - target: 'http://backend.thirddomain.eu'
	  - target: 'http://specialbackend.thirddomain.eu'
	    location: '/specialbackend'

## Optional parameters

None.
