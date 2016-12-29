# Summary

## Description

This role installs a minimalist PHP script meant to allow people to change their
LDAP account password via a web interface. The script is installed along with
proper PHP FPM and nginx configuration and is made available in the `/password`
directory when accessed from a browser.

## Prerequired roles

- `base-config`
- `base-packages`
- `nginx`
- `php-fpm`

# Manual steps

# Configuration parameters (ansible variables)

## Mandatory parameters

### `php_ldap_password_remote_server`

Default: "localhost".

The remote LDAP server that the script will interact with. You can use the
`ldaps://` scheme if connecting to a LDAP server with TLS support.

### `php_ldap_password_remote_port`

Default: 389

The port on which to conect to the remote LDAP server.

### `php_ldap_password_domain`

Default: `{{domain_name}}`

The domain managed by your LDAP server for which to push LDAP password changes
for. The default value is consistent with the defaults of the `openldap` role,
in particular the `ldap_managed_domains` variable.

A base LDAP Distinguished Name (DN) will be derived from this variable. That is,
if your domain name is set to "example.com", the DN will be `dc=example,dc=com`
if `php_ldap_password_domain` is kept to its default.

### `php_ldap_password_users_subtree`

Default: `ou=mail`

The path to the below the root DN inside which user accounts are located. The
default value is consitent with the defaults of the `openldap` role, in
particular the `ldap_managed_domains` variable and its parameters for each
domain.

The full DN under which to look up the user accounts will be derived from this
variable and `php_ldap_password_domain`. With a domain set to "example.com", the
resulting DN will be `ou=mail,dc=example,dc=com` if this variable stays to its
default value.

The PHP script tries to authenticate the login only against accounts directly
below the DN as describe above. Therefore, the accounts must be directly
available under the DN, and not under subtrees in below level.

### `php_ldap_password_login_attributes`

Default: `[ "uid", "mail" ]`

The LDAP attributes that will be tried by the PHP script to authenticate the
provided login with the provided password. With the default setting, in a usual
LDAP tree, users would be able to authenticate with either their user ID or
e-mail address indifferently.

### `php_ldap_password_scriptname`

Default: "changepassword.php"

The file name that the script must be called. With the default setting, the
script would be accessible through the URL
<http://yourdomain.com/password/changepassword.php>. You may call it "index.php"
to be able to access in via <http://yourdomain.com/password/>.

### `web_vhost_php_ldap_password`

Default: `{{server_name}}.{{domain_name}}`

If you have several virtual hosts defined in the `websites` variable (see the
`nginx` role documentation), this option lets you specify on which virtual host
this script should be responding.

## Optional parameters

None.
