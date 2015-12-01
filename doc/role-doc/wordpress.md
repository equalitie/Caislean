# Summary

## Description

This role downloads and installs Wordpress from their official website, and
installs an Nginx configuration file containing a `location` block, making the
Wordpress instance available under the `/wordpress/` HTTP subdirectory. It also
creates a dedicated `wordpress` system user and creates a separate PHP-FPM
instance running as this user.

In order to finalize the Wordpress installation, you will need to access it
through HTTP as soon as the Ansible Wordpress playbook is finished. Wordpress is
able to authentify users against the LDAP database with the proper plugin.

## Prerequired roles

- `common`
- `tls`
- `nginx`
- `php-fpm`
- `mysql`
- `openldap` (if using LDAP user authentication)

# Manual steps

## Finalizing Wordpress installation

Assuming that your server is at `caislean.example.org`, connect to the following
URL with your web browser after having pushed the relevant Wordpress Ansible
recipes: <https://caislean.example.org/wordpress/>. Make sure you are using
`https` and not `http`, as the information that you will enter contains a login
and a password.

You will be prompted for:

- a username: this user will have full privileges on the Wordpress installation
- a password associated with this username: make sure you choose a strong enough
  password
- your email address, to receive notifications from your Wordpress installation.

Fill this information and click the "Install Wordpress" button.

Wordpress will create its database tables and then let you sign in with the
username and password you just entered.

## Allowing LDAP users into Wordpress

If you wish to allow the LDAP users to log into Wordpress, you can use the
[wpDirAuth](https://wordpress.org/plugins/wpdirauth/) plugin:

- move into the Plugin section and click "Add new"
- search for _wpDirAuth_ and click "Install now"
- once the plugin is installed, go to the "Directory Auth." submenu in the
  Settings menu
- configure the plugin as follows:
    - select "Yes" to "Enable Directory Authentication"
    - input `localhost` in "Directory Servers"
    - write `mail` in "Account Filter"
    - write `ou=mail,dc=example,dc=org` (change this according to your domain
      name) in "Base DN"
    - customize or blank Institution Name, Login Screen Message and Password
      Change Message

Users can now log in using their email address and usual password. They will have
the "Subscriber" role by default upon their first login. You can change this
once they have logged in once.

## Keeping Wordpress up-to-date

Keeping Wordpress up-to-date is crucial for your server's security. Wordpress
and its plugins can be updated directly from the web administration interface.
Make sure you periodcally check that your installation is up-to-date.

# Configuration parameters (ansible variables)

## Mandatory parameters

### `server_name`

The machine name of the administered server, e.g. "mycomputer".

### `domain_name`

The domain name, e.g. "mydomain.org".

### `mysql_root_password`

`root` user password for MySQL installation.

### `wordpress_mysql_password`

Password for the `wordpress` MySQL user used by Wordpress.

## Optional parameters

None.
