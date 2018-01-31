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

- `base-packages`
- `base-config`
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

## Changing the location from which wordpress is served

By default, Caislean serves wordpress from a subdirectory of the website for
your server, which is installed by the `nginx` role. This can be changed using
the optional parameters described below. The possibilities are:

- `https://server_name.domain_name/wordpress/` <- default
- `https://server_name.domain_name/wordpress_subdirectory/`
- `https://server_name.domain_name/`
- `https://wordpress_domain_name/wordpress`
- `https://wordpress_domain_name/wordpress_subdirectory`
- `https://wordpress_domain_name/`

See the section on optional parameters for an explanation of the variables in
the examples above and how they interrelate.

## Allowing LDAP users into Wordpress

If you wish to allow the LDAP users to log into Wordpress, you must install the
php5-ldap package for the OS, and the
[wpDirAuth](https://wordpress.org/plugins/wpdirauth/) plugin for wordpress. You
can install both by setting the optional `wordpress_ldap_auth` parameter. To
configure Wordpress to use LDAP authentication:

- Move into the Plugin section and click "activate" for the wpDirAuth plugin.
- Go to the "Directory Auth." submenu in the Settings menu
- Configure the plugin as follows:
    - select "Yes" to "Enable Directory Authentication"
    - select "Yes" to "Automatically Register Authenticated Users"
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

### `wordpress_subdirectory`

Tells Caislean whether to configure wordpress for installation in the document
root of its domain or as a subdirectory. This is the difference between the
wordpress blog appearing at `https://server_name.domain_name` (document root)
and `https://server_name.domain_name/wordpress/` (subdirectory = `wordpress`).

Default value: `true`. Set to `false` to serve from the document root.

### `wordpress_install_path`

Tells Caislean where to install wordpress.

Default value: `wordpress` (suitable for a subdirectory installation - see the
`wordpress_subdirectory` parameter.

With `wordpress_subdirectory = true`, set this optional parameter to some other
string to have that be the subdirectory from which wordpress is served. For
example setting `wordpress_install_path = blog` will cause wordpress to be
served from `https://server_name.domain_name/blog`

With `wordpress_subdirectory = false`, this parameter should be set to match
the `wordpress_domain_name` parameter. This can be done with
`wordpress_subdirectory = "{{ wordpress_domain_name }}"`.

### `wordpress_domain_name`

Tells Caislean the domain name from which wordpress will be served.

Default value: `"{{ server_name }}.{{ domain_name }}"`.

Changing this value will install a new nginx virtual server for the specified
domain. You should ensure this domain name resolves to your server.  You should
also adjust the `tls` role, and the `letsencrypt` role if in use, to include
this domain in your TLS certificates.

### `wordpress_ldap_auth`

Tells Caislean whether to install the php5-ldap package and wpDirAuth wordpress
plugin, which ae required for Wordpress authentication against LDAP to work.
LDAP authentication depends on the `ldap` role.

Default value: `false`. Set to `true` to enable this option.

### `wordpress_network`

Tells Caislean to enable the installation of wordpress as a network.  See the
[wordpress documentation](http://codex.wordpress.org/Create_A_Network) for more
information. Specifically, enabling this option will complete step 2, "Allow
Multisite". Further manual configuration must be completed by following the
rest of the instructions on that page.

Setting this option also installs the [wordpress domain-mapping
plugin](https://wordpress.org/plugins/wordpress-mu-domain-mapping/), however
this will not be available until the following line is added to the
`wp-config.php` file, which can be found in the `wordpress_install_path`
directory.

`define( 'SUNRISE', 'on' );`

This line must be added above the following comment in that file:

`/* That's all, stop editing! Happy blogging. */`

More information can be found in the [plugin installation
instructions](https://wordpress.org/plugins/wordpress-mu-domain-mapping/installation/).

Default value: `false`. Set to `true` to enable this option.
