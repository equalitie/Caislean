# Summary

## Description

This role configures nginx to use certificates issued by [Let's
Encrypt](https://letsencrypt.org/) instead
of self-signed certificates installed by Caislean's TLS role. The advantage is
that Let's Encrypt certificates are trusted by most browsers so visitors to
your website won't see an untrusted certificate warning.

## Notes

More information about Let's Encrypt can be found here:
https://letsencrypt.org/

Use of this role implies acceptance of the Let's Encrypt Subscriber Agreement.
This is available here: https://letsencrypt.org/repository/

The Let's Encrypt role will only work on remote machines running Debian 8
(Jessie) or later. This is because the Let's Encrypt client is only available
in Debian Testing (stretch).

This role adds the "testing" repository to the remote machine. The role also
specifies apt preferences to make sure software is installed from the stable
repositories unless explicitly specified otherwise.

This role won't work unless `website_domain_name` resolves to the IP address of
the remote machine. This is because Let's Encrypt verifies that you control the
domain for which you're requesting a certificate by placing a file in your
webserver's webroot and then checking that it can access that file from the domain
in question.

## Prerequired roles

- `common`
- `tls`
- `nginx`

# Manual steps

# Configuration parameters (ansible variables)

## Mandatory parameters

### `website_domain_name`

The domain name of the website you are serving from this machine (e.g.
example.com)

### `webmaster_email`

The email address of the person responsible for administering the website (e.g.
webmaster@example.com)

## Optional parameters

None.
