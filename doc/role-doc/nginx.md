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

### `nginx_cleartext_ports`

Default: `[ 80 ]`

A set of TCP ports that `nginx` will listen on for cleartext HTTP connections.

### `nginx_tls_ports`

Default: `[ 443 ]`

A set of TCP ports that `nginx` will listen on for HTTPS (HTTP over TLS)
connections.

### `websites`

Default: `[ name:` _server name_`.`_domain name_ `]`

A set of host names that your web server will serve content for. There can be
any number of names, but the default entry is mandatory, as otherwise this or
other roles will fail. The parameter `name` has to appear explicitly. An
optional array `aliases` can be used in order to serve the same content for
several domain names.

The role creates a folder `/var/www/<name>/` for every entry, and static content
in each of these directories will be served by nginx when your web server is
accessed with the corresponding host name. A folder `/etc/nginx/include/<name>/`
is also created for each entry, in which additional nginx configuration files
can be placed (for example to enable TLS for the given hostname or to set up a
PHP-enabled application in a specific subfolder — some other Caisleán roles will
put files there).

The optional arrays `tls_ports` and `cleartext_ports` can be used for each host
name to indicate which TCP ports will serve it, respectively for HTTPS and HTTP
(cleartext) connections. If not specified, values of `nginx_tls_ports` and
`nginx_cleartext_ports`, respectively, will be used (see above).

A number of reverse proxies can be optionally configured for each host name by
specifying the parameter `reverse_proxy`, inside which the mandatory parameter
`target` must be set to the remote URL to proxy to and the optional parameter
`location` must be set to the local path where the proxying will be done (it is
set to `/` if left empty). Additional `nginx` options for this reverse proxy can
be specified under the parameter `options`, using a series of `option_name` and
`option_value` parameters.

The headers `X-Real-IP` and `X-Forwarded-For` are automatically added and do not
have to be added as options.

Example:

    websites:
      - name: "{{server_name}}.{{domain_name}}"
        cleartext_ports: [ 8080, 8081 ]
      - name: www.otherdomain.com
        aliases:
          - www.otherdomain.org
          - otherdomain.org
      - name: frontend.thirddomain.eu
        reverse_proxy:
	  - target: 'http://backend.thirddomain.eu'
	  - target: 'http://specialbackend.thirddomain.eu'
	    location: '/specialbackend'
            options:
              - option_name: proxy_redirect
                option_value: 'off'
              - option_name: proxy_add_header
                option_value: 'X-Forwarded-Proto $scheme'

## Optional parameters

### `tls_additional_domains`

A set of additional domains for which nginx will also serve content in HTTPS.
These domains must be defined in the `websites` variable, or the role will fail
to execute. The default domain name must not be specified in this variable, as
TLS is enabled for it by default.

See the `tls` role documentation for more information on this parameter. Do not
specify domains for which you want Let's Encrypt certificates in this paramter.
See the `letsencrypt` role documentation.
