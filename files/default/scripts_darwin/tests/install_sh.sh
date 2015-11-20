#!/bin/bash
run_cmd rm -rf /opt/chef

echo "Grabbing install.sh ..."
run_cmd timeout 60 curl https://omnitruck.chef.io/install.sh > /tmp/install.sh && {
  run_cmd timeout 300 sudo -E bash /tmp/install.sh
} || PROXY_TEST_RESULT=failed
