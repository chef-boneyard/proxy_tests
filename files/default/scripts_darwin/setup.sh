#!/bin/sh
PROXY_TESTS_DIR=$(dirname $0)

# Install Squid through Homebrew
brew install squid
ln -sfv /usr/local/opt/squid/*.plist ~/Library/LaunchAgents
mkdir -p /usr/local/opt/squid/etc
mkdir -p /usr/local/var/cache/squid
mkdir -p /usr/local/var/logs

sudo bash $PROXY_TESTS_DIR/install_chefdk.sh
