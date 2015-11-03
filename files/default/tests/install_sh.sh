#!/bin/sh
echo "Clearing chef package with yum erase -y chef (if it's already there) ... "
yum erase -y chef

echo "Grabbing install.sh and running it via curl https://www.chef.io/chef/install.sh | sudo -E bash ..."
curl https://www.chef.io/chef/install.sh | sudo -E bash
