#!/bin/sh
echo "Stopping squid ..."
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.squid.plist

# Make the right config file
run_cmd cp $PROXY_TESTS_DIR/proxies/single/squid.conf /usr/local/opt/squid/etc/squid.conf

# Set the DNS server to 1.1.1.1 so that all lookups fail
echo "Setting the DNS server to 1.1.1.1"
echo "Current DNS settings:\n$(networksetup -getdnsservers wi-fi)"
networksetup -setdnsservers wi-fi 1.1.1.1

echo "Starting squid ..."
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.squid.plist
# For some reason on OSX it takes a super long time for squid to restart
# FATAL: Ipc::Mem::Segment::create failed to ftruncate(/squid-cf__metadata.shm): (22) Invalid argument
sleep 60
