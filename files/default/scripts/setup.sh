#!/bin/sh
PROXY_TESTS_DIR=$(dirname $0)
sudo yum install -y squid git
route add -net 127.0.0.0 netmask 255.0.0.0 dev lo
sudo bash $PROXY_TESTS_DIR/install_chefdk.sh
