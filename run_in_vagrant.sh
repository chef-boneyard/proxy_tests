#!/bin/bash

set -e

if [ `uname -s` = "Darwin" ]; then
  echo "This script will not work on OS X. Run it inside the Vagrant VM."
  exit 1
fi

dk_version=0.11.2
deb_file=chefdk_${dk_version}-1_amd64.deb

if [ ! -x /opt/chefdk/bin/chef ]; then
  sudo dpkg -i $deb_file 2> /dev/null

  if [ $? != 0 ]; then
    "Couldn't install from $deb_file; is it present?"
    exit 1
  fi
fi

eval "$(/opt/chefdk/bin/chef shell-init bash)"

export PROXY_TESTS_DIR=/tmp/proxy_tests
export PROXY_TESTS_REPO=$PROXY_TESTS_DIR/repo

chef-client --version
sudo -E chef-client -z -o proxy_tests::render

subject="${1-chef_client}"
proxy_count="${2-none}"
proxy_mechanism="${3-no_proxy}"

sudo -E bash $PROXY_TESTS_DIR/run_tests.sh $subject $proxy_count $proxy_mechanism

echo "proxy_tests output is in /tmp/out.txt"
echo "squid logs are in /var/log/squid3"
