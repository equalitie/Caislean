# Summary

## Description

This role installs an email system, with Postfix as the SMTP server and Dovecot
to provide IMAP access to mailboxes. Both are setup with proper TLS support and
cipherlists.

Users are authenticated against the LDAP database both for sending e-mails and
for accessing their mailboxes. Whenever e-mails come from the outside, only
valid LDAP users in the `mail` organizational unit will have their messages
delivered. See the `openldap` role documentation for more information on the
LDAP structure.

## Prerequired roles

- `base-packages`
- `base-config`
- `tls`
- `openldap`

# Manual steps

## Register the server as mail exchanger in DNS entries

Add the following DNS entries to your zone:

    mail   IN    A      <server-public-ip>
    @      IN    MX     10 mail

If, in addition, your server has a public IPv6 address, add this entry:

    mail   IN    AAAA  <server-public-ipv6>

## Anti-spam SPF and DKIM setup

### SPF DNS entry

Add the following entries to your DNS zone:

    @      IN    TXT   "v=spf1 mx ip4:<server-public-ip> ip6:<server-public-ipv6> -all"
    @      IN    SPF   "v=spf1 mx ip4:<server-public-ip> ip6:<server-public-ipv6> -all"

### DKIM setup

Make sure you configure the `dkim_directory` Ansible variable with a local path
you will use to manage your DKIM keys. For this example we will use
`/home/user/caislean_admin/dkim`.

Move to that directory and create an RSA keypair (use exactly `dkim.priv` and
`dkim.pub` as filenames):

    cd /home/user/sec_comms_admin/dkim
    umask 077
    openssl genrsa -out dkim.priv 4096
    openssl rsa -in dkim.priv -out dkim.pub -pubout

The file `dkim.pub` contains the DKIM RSA public key for your domain. It will
appear in a `TXT` DNS record as a one-line string. Obtain this one-line string
from `dkim.pub` like this:

    tail -n +2 dkim.pub | head -n -1 | tr -d '\n'

Finally, add the following DNS entry to your domain, replacing `...` with the
result of the previous command:

    dkim1._domainkey  IN    TXT  "v=DKIM1; k=rsa; p=..."

# Configuration parameters (ansible variables)

## Mandatory parameters

### `server_name`

The machine name of the administered server, e.g. "mycomputer".

### `domain_name`

The domain name, e.g. "mydomain.org".

### `dkim_directory`

Local directory where DKIM keys are stored.

## Optional parameters

None.
