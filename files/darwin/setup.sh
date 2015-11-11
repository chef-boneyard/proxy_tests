#!/bin/sh

# Install Squid through Homebrew
brew install squid
ln -sfv /usr/local/opt/squid/*.plist ~/Library/LaunchAgents
mkdir -p /usr/local/var/cache/squid
mkdir -p /usr/local/var/logs

sudo bash /opt/proxy_tests/files/default/install_chefdk.sh
