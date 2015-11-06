#!/bin/sh
# Stop squid
run_cmd service squid stop
# Allow all traffic
run_cmd iptables -F OUTPUT
