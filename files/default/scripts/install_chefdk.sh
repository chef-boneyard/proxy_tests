# Install chefdk if needed
PROXY_TESTS_DIR=$(dirname $0)
source $PROXY_TESTS_DIR/utils.sh

echo "Installing chefdk (if needed) ..."
run_cmd curl -o /tmp/install.sh https://omnitruck.chef.io/install.sh
# Must specify a version otherwise the script re-installs every time
run_cmd sudo -E bash /tmp/install.sh -P chefdk -v 0.10.0
eval "$(/opt/chefdk/bin/chef shell-init bash)"
