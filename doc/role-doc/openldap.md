# Summary

## Description

This role installs the OpenLDAP server, sets its administrative password and
creates a `mail` organisation unit (OU) under the directory base.

This OU is deemed to contain user entries for authentication by services like
Postfix and Dovecot, OpenVPN, Owncloud, Wordpress, etc. At the moment, these
other services use users' email address as login.

Note: if changing the administrative password is needed, it has to be done
manually on the server and then by editing the recipe's variables.

Note: this setup uses a flat `slapd` configuration file instead of storing the
configuration within the LDAP tree itself, which is now considered as a
deprecated practice and should thus be changed in the future.

## Prerequired roles

- `base-packages`
- `base-config`

# Manual steps: managing users in the LDAP database

How to grant and revoke access to owncloud and email service by interacting with
the LDAP database. Note: this does not apply to the LDAP tree used for
authentication by Samba.

## Administrator account configuration

Make sure you set the variable `ldap_admin_pass` before running the playbook for
the first time.

## Adding a user

Here are the attributes to set:

- `cn`: user's common name
- `mail`: the user's actual email address
- `mailbox`: local user ID to deliver the mail to, followed by a trailing `/`
- `userPassword`: user's password (use `ldappasswd` to set, see below)

### How to add a user

Create a LDIF file on your server, called for instance `newuser.ldif`, with the
following content:

    dn: cn=LDAP Test User, ou=mail, dc=example, dc=org
    cn: LDAP Test User
    objectclass: organizationalRole
    objectclass: simpleSecurityObject
    objectclass: mailAccount
    mail: test@example.org
    mailbox: test/
    userPassword: 

Add the user into the database with the following command (you will be prompted
for the LDAP admin password):

    ldapadd -W -D cn=admin,dc=example,dc=org -f newuser.ldif

If the user has successfully been added, you can delete the LDIF file:

    rm newuser.ldif

The user's password can be set using the following command:

    ldappasswd -W -S -D cn=admin,dc=example,dc=org "cn=LDAP Test User,ou=mail,dc=example,dc=org"

You will be prompted to enter twice the new user's password and then to enter
your administrator password.

The new user's login will be their full email address (`test@example.org`).

## Revoking access

To delete a user's account, simply remove their LDAP corresponding entry:

    ldapdelete -W -D cn=admin,dc=example,dc=org "cn=LDAP Test User,ou=mail,dc=example,dc=org"

# Configuration parameters (ansible variables)

## Mandatory parameters

### `ldap_bind_addresses`

Default: `[ 127.0.0.1 ]`

Local IP addresses for the OpenLDAP server to listen on. By default we only
listen on the local interface (127.0.0.1). You can specify any number of IP
addresses assigned to your server. IPv6 addresses must go between square
brackets. You should be able to use special addresses `0.0.0.0` (IPv4) and `::`
(IPv6) to listen on all network interfaces.

Be careful if you bind public IP addresses: the LDAP protocol is not encrypted
and LDAP over TLS is not (yet) supported by Caislean. Binding non-loopback
addresses may still be useful on a local area network or on a virtual network
between virtual machines.

Example:

    ldap_bind_addresses:
      - 127.0.0.1
      - '[::1]'

### `ldap_admin_pass`

The LDAP administrator password.

### `ldap_managed_domains`

Default: `[ domain: domain_name ]`

List of domain names managed in the LDAP directory. The role will create one
separate LDAP database for each of the domains.

Optionally, use the parameter `admin_pass` to set an administrator password
specific of a given domain (otherwise the password set in `ldap_admin_pass` will
be used). For any given domain `example.com`, the administrator account to which
to identify is `cn=admin,dc=example,dc=com`.

Optionally, use parameters `users_ou` and `groups_ou` to define custom
organizationalUnit (OU) entries meant to contain your users and groups. If
unset, the `mail` OU will contain users, and no OU is created for groups. For
now, changing the users OU will break all Caislean roles that query LDAP for
user authentication (`virtualmail`, `prosody`, etc.).

Example:

    ldap_managed_domains:
      - domain: "{{ domain_name }}"
      - domain: additionaldomain.com
      - domain: some_other_domain.org
        admin_pass: specificadminpass
      - domain: somethingelse.com
        users_ou: MyUsers
        groups_ou: MyGroups

### `domain_name`

The domain name, e.g. "mydomain.org".

## Optional parameters

None.
