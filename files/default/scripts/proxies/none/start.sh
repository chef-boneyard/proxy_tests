#!/bin/bash
# Stop squid
run_cmd service squid3 stop
# Allow all traffic
run_cmd iptables -F OUTPUT
