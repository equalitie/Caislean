# Summary

## Description

This role installs the Owncloud package from the Owncloud official repositories
and installs the proper Nginx configuration file containing a `location` block
that configures the `/owncloud/` HTTP directory properly, also with forwarding
PHP requests to `php-fpm`. It also installs a dedicated `php-fpm` service,
running as a distinct `owncloud` user.

Note that after installation of the package through the Ansible playbook,
finalizing the installation is done via web access to the Owncloud instance. You
should do it right away as it lets you set the Owncloud administrator account
and password.

## Prerequired roles

- `base-packages`
- `base-config`
- `tls`
- `nginx`
- `php-fpm`
- `mysql`
- `openldap` (if using local LDAP authentication)

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
- choose a database name freely, use `root` for the username, and fill in the
  password you already set with the variable `mysql_root_password`: Owncloud
  will use this account only once to create its own tables and less privileged
  MySQL account, and then will use it in the future.

## Connection to the LDAP directory

Log into Owncloud using your new administrator account. Use the button in the
upper-left corner and select the _Apps_ screen. Go to the _Not enabled_ tab and
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

You may also connect Owncloud to another LDAP server, in which case you will
have to adapt the settings according to its configuration.

## Enabling calendar and contacts management

- log into your Owncloud instance with the administrator account
- click on the top-left menu and select "Apps"
- select the PIM category
- enable both Calendar and Contacts applications
- log out: when you log back in, or whenever any user logs in, management of
  calendar and contacts becomes possible.

# Configuration parameters (ansible variables)

## Mandatory parameters

### `mysql_root_password`

`root` user password for MySQL server.

## Optional parameters

None.
