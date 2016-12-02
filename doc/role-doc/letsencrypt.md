# Summary

## Description

This role generates certificates validated by the [Let's
Encrypt](https://letsencrypt.org/) free certification authority (CA) for the
domains having services set up by these roles:

- `nginx`

Make sure your playbook calls the role `letsencrypt` before these roles.

If you do not need to manage your own CA, Let's Encrypt certificates can replace
favourably those installed by Caisleán's role `tls` because Let's Encrypt
certificates are trusted by most client software, and visitors of your online
services will not see an untrusted certificate warning.

You can also combine self-managed certificates for some domains (via the `tls`
role) and Let's Encrypt certificates for others, by explicitly excluding the
self-managed domains from being set up with Let's Encrypt. See configuration
parameters below for details.

This role will only work on remote machines running Debian 8 (Jessie). This is
because the Let's Encrypt client is not available on Debian 7 (Wheezy) but is
present in Jessie's backports repository.

Use of this role implies acceptance of the [Let's Encrypt Subscriber
Agreement](https://letsencrypt.org/repository/).

## Prerequired roles

- `base-packages`
- `base-config`

# Manual steps

Make sure your DNS records are properly configured for each domain prior to
running this role: if you want a Let's Encrypt certificate for
`www.somedomain.tld`, this exact name must have an `A` and/or `AAAA` record
pointing to your server's IP address.

This role will fail unless every domain for which you did not disable Let's
Encrypt has this proper configuration. This is because Let's Encrypt verifies
that you control the domains for which you are requesting certificates
by placing files in each virtual host's webroot and then checking that it can
access those files from the domains in question.

# Configuration parameters (ansible variables)

## Mandatory parameters


## Optional parameters

### `websites`

The list of domain names configured by the `nginx` role for which Caislean
should generate certificates. See that role's documentation for more options of
this configuration parameter.

Default:

    websites:
      - name: "{{ server_name }}.{{ domain_name }}"

Add or change lines to create new nginx virtual hosts and generate Let's Encrypt
certificates for them. To disable Let's Encrypt for a given domain, you must set
explicitly the `letsencrypt` parameter to `False` for the domain.

The role will generate one distinct certificate per domain, except if a domain
has aliases, in which case the domain and all its aliases will be included in
the same certificate.

Example:

    websites:
      - name: "{{server_name}}.{{domain_name}}"
      - name: www.otherdomain.com
        aliases:
          - otherdomain.com
          - otherdomain.org
          - www.otherdomain.org
      - name: cleartext.domain.com
        letsencrypt: False

### `tls_additional_domains`

Domains listed under this parameter will be excluded from Let's Encrypt
certificate requests. This is because we consider that their TLS is already
handled by the `tls` role, using certificates and keys that you will have
created manually on your local machine. See documentation of that role.

### `letsencrypt_additional_domains`

Domains listed under this parameter will be additionally requested for a Let's
Encrypt certificate, even if there are no Caisleán role configured to provide a
service under these domain names.

This can be useful if you need a service that Caisleán does not provide but want
to have Let's Encrypt set up for it.

Example:

    letsencrypt_additional_domains:
      - yet-another-domain.me
