#!/bin/sh
PROXY_TESTS_REPO=$PROXY_TESTS_DIR/repo
AUTH_ARGS="-c $PROXY_TESTS_REPO/.chef/knife.rb -u client-creator --key $PROXY_TESTS_REPO/.chef/client-creator.pem"
TEST_CLIENT_NAME=test_client

echo "Recreating client and node ..."
# Create the client/node
run_cmd knife client create $AUTH_ARGS $TEST_CLIENT_NAME -d -f /tmp/client.pem
run_cmd knife node create $AUTH_ARGS $TEST_CLIENT_NAME -d

# Run chef-client
echo "Running chef-client ..."
run_cmd timeout 120 chef-client -c $PROXY_TESTS_REPO/.chef/knife.rb -N $TEST_CLIENT_NAME --client_key /tmp/client.pem -o test || PROXY_TEST_RESULT=failed
