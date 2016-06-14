# Summary

## Description

This roles install `ufw` and sets it up to forbid all inbound and outbound
traffic excepted:

- SSH port and port 25 inbound;
- ports 25, 53, 80 and 443 outbound.

It is up to other roles that need to open more ports for additional services
(such as a web server or a XMPP server) to do so.

This role is automatically included in the `common` role.

## Prerequired roles

- `base-packages`
- `base-config`

# Manual steps

# Configuration parameters (ansible variables)

## Mandatory parameters

### `ufw_allow_ports_out`

Default: `[25, 53, 80, 443]`

List of TCP and UDP ports for which outbound traffic will be allowed by the
firewall.

### `ufw_allow_ports_in`

Default: `[`_ssh port_`, 25]`

List of TCP and UDP ports for which inbound traffic will be allowed by the
firewall.

### `ufw_allow_ips_out`

Default: `[]`

List of IP addresses that should be allowed for outbound connections, on any
port or protocol.

### `ufw_allow_ips_in`

Default: `[]`

List of IP addresses that should be allowed for inbound connections, on any port
or protocol.

## Optional parameters

None.
