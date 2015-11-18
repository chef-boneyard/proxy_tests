#!/bin/bash
echo "Stopping squid ..."
run_cmd service squid3 stop

# Make the right config file
echo "Copying squid configuration ..."
run_cmd cp $PROXY_TESTS_DIR/proxies/single/squid.conf /etc/squid3/squid.conf

# Deny all traffic except squid
echo "Setting routes to deny all traffic except ssh and squid ..."
run_cmd iptables -F OUTPUT
run_cmd iptables -A OUTPUT -o enp0s3 -p tcp --dport 22 -j ACCEPT
run_cmd iptables -A OUTPUT -o enp0s3 -m owner --uid-owner root -j ACCEPT
run_cmd iptables -A OUTPUT -o enp0s3 -m state --state NEW -p tcp -j DROP
run_cmd iptables -A OUTPUT -j ACCEPT

echo "Starting squid ..."
run_cmd service squid3 start
sleep 2
