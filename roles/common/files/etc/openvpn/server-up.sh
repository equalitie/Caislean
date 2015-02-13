#/bin/bash

iptables -t nat -I POSTROUTING 1 -s 10.1.0.0/24 -j MASQUERADE

sysctl net.ipv4.ip_forward=1
sysctl net.ipv6.conf.all.forwarding=1
