#!/bin/bash
echo "Clearing chef package with yum erase -y chef (if it's already there) ... "
run_cmd yum erase -y chef

echo "Grabbing install.sh ..."
run_cmd timeout 60 curl https://omnitruck.chef.io/install.sh > /tmp/install.sh && {
  run_cmd timeout 300 sudo -E bash /tmp/install.sh
} || PROXY_TEST_RESULT=failed
