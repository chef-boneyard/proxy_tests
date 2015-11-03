#!/bin/sh
# Stop squid
service squid stop
# Allow all traffic
iptables -F OUTPUT
