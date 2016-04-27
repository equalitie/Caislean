# Summary

## Description

This role sets up a basic version of the file `/etc/aliases` to allow the
administrator to receive system alerts to an external e-mail address, and
install `apticron` to notify of available package updates.

This role is automatically included in the `common` role.

## Prerequired roles

None.

# Manual steps

# Configuration parameters (ansible variables)

## Mandatory parameters

### `admin_email`

Email address of the administrator, where Cron messages and various security
alerts will be sent to.

## Optional parameters

None.
