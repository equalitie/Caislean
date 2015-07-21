#!/bin/bash

iptables -t nat -D POSTROUTING 1

sysctl net.ipv4.ip_forward=0
sysctl net.ipv6.conf.all.forwarding=0
