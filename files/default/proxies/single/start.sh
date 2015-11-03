#!/bin/sh
echo "Stopping squid ..."
service squid stop

# Make the right config file
echo "Copying squid configuration /opt/proxy_tests/files/default/proxies/single/squid.conf to /etc/squid/squid.conf ..."
cp /opt/proxy_tests/files/default/proxies/single/squid.conf /etc/squid/squid.conf

# Deny all traffic except squid
echo "Setting routes to deny all traffic except ssh and squid ..."
iptables -F OUTPUT
iptables -A OUTPUT -o enp0s3 -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -o enp0s3 -m owner --uid-owner squid -j ACCEPT
iptables -A OUTPUT -o enp0s3 -m state --state NEW -p tcp -j DROP
iptables -A OUTPUT -j ACCEPT

echo "Starting squid ..."
service squid start
