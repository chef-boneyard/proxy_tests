#!/bin/bash
PROXY_TESTS_REPO=$PROXY_TESTS_DIR/repo
AUTH_ARGS="-c $PROXY_TESTS_REPO/.chef/knife.rb -u client-creator --key $PROXY_TESTS_REPO/.chef/client-creator.pem"
TEST_CLIENT_NAME=test_client

echo "Recreating client and node ..."
# Destroy existing client/node so they will get re-created
run_cmd knife node delete $TEST_CLIENT_NAME $AUTH_ARGS -y
run_cmd knife client delete $TEST_CLIENT_NAME $AUTH_ARGS -y
# Create the client/node
run_cmd knife client create $TEST_CLIENT_NAME $AUTH_ARGS -d -f /tmp/client.pem
run_cmd knife node create $TEST_CLIENT_NAME $AUTH_ARGS -d

# Run chef-client
echo "Running chef-client ..."
run_cmd timeout 120 chef-client -c $PROXY_TESTS_REPO/.chef/knife.rb -N $TEST_CLIENT_NAME --client_key /tmp/client.pem -o test || PROXY_TEST_RESULT=failed
