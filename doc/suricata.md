# Summary

## Description

## Prerequired roles

# Manual steps

# Configuration parameters (ansible variables)

## Mandatory parameters

### `admin_email`

Email address of the administrator, where Cron messages and various security
alerts will be sent to.

### `capture_traffic`

Set to `yes` or `no`: whether or not to capture all the traffic into a PCAP
file, as permitted by the `pcap-log` output supported by Suricata.

### `in_out_monitor_only`

Monitor only trafic that is emitted by or directed to the machine.

### `monitored_interfaces`

A list of network interfaces to monitor.

### `server_addresses`

List of valid IP addresses that identify the server (used to determine whether
some trafic is emitted by or directed to the server).

## Optional parameters

(none)
