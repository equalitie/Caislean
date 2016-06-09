# Summary

## Description

This role installs the Prosody XMPP server, with a TLS cipherlist aiming at
protecting decently communications to and from the server, and with
authentication against the locally running LDAP server (through `saslauthd`
daemon), using users' email addresses as login.

## Prerequired roles

- `base-packages`
- `tls`
- `openldap`

# Manual steps

## DNS settings for XMPP server

Assuming your domain is _domain.com_ and your server running at
_caislean.domain.com_, add the following DNS entries for _domain.com_:

    _xmpp-client._tcp    IN    SRV    0 5 5222      caislean
    _xmpp-server._tcp    IN    SRV    0 5 5269      caislean
    _xmpp-server._tcp.conference   IN SRV  0 5 5269 caislean

These settings will allow clients and servers to find your server for all
accounts looking like _user@domain.com_, as well as finding the multiuser
chatroom service provided by your XMPP server on domain `conference.domain.com`.

The Prosody documentation provides extensive
[explanations](https://prosody.im/doc/dns) on the DNS configuration.

## Accepting your server's TLS certificate on clients

In order to avoid repeated warnings or even clients refusing to connect due to
your TLS certificate not being trusted, users will need to make sure your CA
certificate is trusted by their XMPP client.

Pidgin will typically not connect to the server in its default configuration.
[This page](http://cl0secall.net/post/425) explains how to make it trust a root
CA certificate, and [this
one](http://www.maketecheasier.com/having-pidgin-ssl-certificate-error-heres-the-fix/)
how to make it trust single per-host certificates.

# Configuration parameters (ansible variables)

## Mandatory parameters

### `server_name`

The machine name of the administered server, e.g. "mycomputer".

### `domain_name`

The domain name, e.g. "mydomain.org".

## Optional parameters

None.
