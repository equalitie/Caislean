# Summary

## Description

This roles install `ufw` and sets it up to forbid all inbound and outbound
traffic excepted:

- ports 22 and 25 inbound;
- ports 25, 53, 80 and 443 outbound.

It is up to other roles that need to open more ports for additional services
(such as a web server or a XMPP server) to do so.

This role is automatically included in the `common` role.

## Prerequired roles

- `base-packages`

# Manual steps

# Configuration parameters (ansible variables)

## Mandatory parameters

None.

## Optional parameters

None.
