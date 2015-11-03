echo "Clearing chef package from system (if it's already there) ... "
yum erase -y chef
curl https://www.chef.io/chef/install.sh | sudo bash -s
