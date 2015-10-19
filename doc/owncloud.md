# Summary

## Description

## Prerequired roles

# Manual steps: finalizing Owncloud setup

## Administrator account

As soon as Owncloud has been setup by Ansible, use your browser to connect to
the following address:

    https://server.example.org/owncloud/

This will display the Owncloud initial configuration page. Configure the
required settings as follows:

- specify a new administrator account
- leave the default storage folder to `/var/www/owncloud/data`
- select MySQL as database backend
- use `owncloud` for both database name and username, and fill in the password
  you already set with the variable `owncloud_mysql_password`

## Connection to the LDAP directory

Log into Owncloud using your new administrator account. Use the button in the
upper-left corner and select the _Apps_ screen. Go the the _Not enabled_ tab and
enable the _LDAP user and group backend_ application with the _Enable_ button.

Click on your login in the upper-right corner and select _Admin_ and scroll down
to the LDAP configuration. Configure the application as follows:

- use `localhost` for server and 389 for port;
- leave User DN and password empty;
- set _Base DN_ to `ou=mail, dc=example, dc=org` (replace `dc=example, dc=org`
  by what corresponds to your actual domain name)
- in the User filter tab, enter `objectClass=mailAccount` as raw filter
- in the Login filter tab, enter `mail=%uid` as raw filter
- in the Group filter tab, enter `objectClass=mailAccount` as raw filter
- select the Advanced tab, scroll down and click on the Save button

# Configuration parameters (ansible variables)

## Mandatory parameters

### `mysql_root_password`

`root` user password for MySQL server.

### `owncloud_mysql_password`

The MySQL password for user `owncloud` (this user is automatically created by
the role).

## Optional parameters

(none)
