# Summary

## Description

This role configures nginx to use certificates issued by [Let's
Encrypt](https://letsencrypt.org/) instead of certificates signed by your own
authority as installed by Caislean's role `tls`. The advantage is that Let's
Encrypt certificates are trusted by most browsers so visitors to your website
won't see an untrusted certificate warning.

## Notes

More information about Let's Encrypt can be found here:
<https://letsencrypt.org/>

Use of this role implies acceptance of the Let's Encrypt Subscriber Agreement.
This is available here: https://letsencrypt.org/repository/

The Let's Encrypt role will only work on remote machines running Debian 8
(Jessie). This is because the Let's Encrypt client is not available on Debian 7
(Wheezy); it is however present in Jessie's backports repository.

This role will not work unless every domain listed in `websites` resolves to the
IP address of your server. This is because Let's Encrypt verifies that you
control the domains for which you are requesting certificates by placing files
in each virtual host's webroot and then checking that it can access those files
from the domains in question.

## Prerequired roles

- `base-packages`
- `base-config`
- `tls`
- `nginx`

# Configuration parameters (ansible variables)

## Mandatory parameters

### `websites`

A list of domain names for which Caislean should generate certificates. This is
the same list used by the `nginx` role when creating virtual hosts to serve.

Default:

websites:
  - "{{ server_name }}.{{ domain_name }}"

Add or change lines to create new nginx virtual hosts and generate letsencrypt
certificates for them.

Example:

websites:
 - "{{ domain_name }}"
 - "www.example.com"

## Optional parameters

None.
