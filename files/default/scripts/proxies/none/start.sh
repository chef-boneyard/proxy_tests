#!/bin/bash
# Stop squid
run_cmd service squid3 stop && echo "stopped successfully"
# Allow all traffic
run_cmd iptables -F OUTPUT
