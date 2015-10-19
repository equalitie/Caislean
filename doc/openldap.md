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

- `common`

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
- `mail`: the actual email address of the user
- `mailbox`: local user ID to deliver the mail to, followed by a trailing `/`
- `userPassword`: user's password (use `ldappasswd` to set, see below)

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

To delete a user's account, simply remove their LDAP coresponding entry:

    ldapdelete -W -D cn=admin,dc=example,dc=org "cn=LDAP Test User,ou=mail,dc=example,dc=org"

# Configuration parameters (ansible variables)

## Mandatory parameters

### `ldap_admin_pass`

The LDAP administrator password.

### `domain_name`

The domain name, e.g. "mydomain.org".

## Optional parameters

None.
