# Install chefdk if needed
echo "Installing chefdk (if needed) ..."
run_cmd curl https://omnitruck.chef.io/install.sh > /tmp/install.sh
run_cmd sudo -E bash /tmp/install.sh -P chefdk
eval "$(/opt/chefdk/bin/chef shell-init bash)"
