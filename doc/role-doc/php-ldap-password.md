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

php_ldap_remote_server: localhost
php_ldap_remote_port: 389
php_ldap_base_dn: "{{domain_name.split('.')|join(',dc=')}}"
php_ldap_login_attributes:
  - uid
    - mail
    web_vhost_php_ldap_password: "{{server_name}}.{{domain_name}}"
    php_ldap_password_scriptname: changepassword.php


### `php_ldap_remote_server`

Default: "localhost".

The remote LDAP server that the script will interact with.

### `php_ldap_remote_port`

Default: 389

The port on which to conect to the remote LDAP server.

### `php_ldap_base_dn`

Default: `"{{domain_name.split('.')|join(',dc=')}}"`

The base DN in which to authenticate users. The script does not search for users
but tries to directly bind using the provided login. Therefore, the accounts
must be directly available under the specified DN, and not under deeper
subtrees.

### `php_ldap_login_attributes`

Default: `[ "uid", "mail" ]`

The LDAP attributes that will be tried by the PHP script to authenticate the
provided login with the provided password. With the default setting, in a usual
LDAP tree, users would typically be able to authenticate with either their user
ID or e-mail address indifferently.

### `php_ldap_password_scriptname`

Default: "changepassword.php"

The file name that the script must be called. With the default setting, the
script would be accessible through the URL
<http://youdomain.com/password/changepassword.php>. You may call it "index.php"
to be able to access in via <http://youdomain.com/password/>.

### `web_vhost_php_ldap_password`

Default: `{{server_name}}.{{domain_name}}`

If you have several virtual hosts defined in the `websites` variable (see the
`nginx` role documentation), this option lets you specify on which virtual host
this script should be responding.

## Optional parameters

None.
