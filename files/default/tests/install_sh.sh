#!/bin/sh
echo "Clearing chef package with yum erase -y chef (if it's already there) ... "
yum erase -y chef

echo "Grabbing install.sh ..."
timeout 60 curl https://www.chef.io/chef/install.sh > /tmp/install.sh && {
  echo "Running sudo -E bash /tmp/install.sh ..."
  timeout 120 sudo -E bash /tmp/install.sh
} || PROXY_TEST_RESULT=failed
