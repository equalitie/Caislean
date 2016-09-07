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
This is available here: <https://letsencrypt.org/repository/>

The Let's Encrypt role will only work on remote machines running Debian 8
(Jessie). This is because the Let's Encrypt client is not available on Debian 7
(Wheezy); it is however present in Jessie's backports repository. The role will
explicitly fail if you try running it on anything else than Jessie.

This role will not work unless every domain listed in `websites` for which you
did not disable Let's Encrypt resolves to the IP address of your server. This is
because Let's Encrypt verifies that you control the domains for which you are
requesting certificates by placing files in each virtual host's webroot and then
checking that it can access those files from the domains in question. Make sure
your DNS records are properly configured for each domain.

## Prerequired roles

- `base-packages`
- `base-config`
- `nginx`

# Configuration parameters (ansible variables)

## Mandatory parameters

### `websites`

A list of domain names for which Caislean should generate certificates. This is
the same list used by the `nginx` role when creating virtual hosts to serve. See
that role's documentation for more options of this configuration parameter.

Default:

    websites:
      - name: "{{ server_name }}.{{ domain_name }}"

Add or change lines to create new nginx virtual hosts and generate Let's Encrypt
certificates for them. You can disable Let's Encrypt by setting explicitly the
`letsencrypt` parameter to `False` for a given domain.

Example:

    websites:
      - name: "{{server_name}}.{{domain_name}}"
        letsencrypt: False
      - name: www.otherdomain.com

## Optional parameters

### `tls_additional_domains`

To avoid generating conflicting TLS files, this role will ignore and therefore
not generate Let's Encrypt certificates for domains listed in
`tls_additional_domains`, as they will have been taken care of in the role
`tls`. See that role's documentation for more details.
