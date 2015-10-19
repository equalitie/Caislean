# Summary

## Description

## Prerequired roles

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
- `mailbox`: local user ID to deliver the mail to
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

    ldappasswd -W -S -D cn=admin,dc=example,dc=org "cn=LDAP Test
User,ou=mail,dc=example,dc=org"

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
