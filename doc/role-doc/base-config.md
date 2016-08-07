# Summary

## Description

This role ensures that the `root` account in `/etc/aliases` forwards messages to
the e-mail address defined by the administrator (see below), and installs
`apticron` to notify of available package updates. It also installs `postfix` to
ensure the e-mail delivery of `apticron` alerts and configures it not to listen
on the network.

This role is automatically included in the `common` role.

## Prerequired roles

None.

# Manual steps

# Configuration parameters (ansible variables)

## Mandatory parameters

### `admin_email`

Email address of the administrator, where Cron messages and various security
alerts will be sent to.

### `base_force_postfix_master_cf`

Default: `False`

This variable decides whether the role is forced to install a postfix
configuration file `master.cf` that disables any network-listening daemon of
postfix, for security reasons. When left to the default (`False`), the role will
refrain from installing it if it detects that that file was previously installed
by the `virtualmail` role, in order to prevent the two roles from fighting for
the same file.

It is useful to set this to `True` if you used to use the `virtualmail` role but
are not using it anymore.

## Optional parameters

None.
