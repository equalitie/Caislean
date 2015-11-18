# Summary

## Description

This role contains tasks meant to bring basic security improvement to the
system: install essential packages and repositories, setting up a firewall using
`ufw`, changing default file creation mask, hardening SSH configuration, etc.

It is strongly recommended to include this role in first position in any
Caislean installation.

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
