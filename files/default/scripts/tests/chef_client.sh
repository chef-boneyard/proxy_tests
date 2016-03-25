#!/bin/bash

AUTH_ARGS="-c $PROXY_TESTS_REPO/.chef/knife.rb -u client-creator --key $PROXY_TESTS_REPO/.chef/client-creator.pem"
TEST_CLIENT_NAME=test_client

env | grep -i proxy | sort

echo "Recreating client and node ..."
# Destroy existing client/node so they will get re-created
run_cmd knife node delete $TEST_CLIENT_NAME $AUTH_ARGS -y
run_cmd knife client delete $TEST_CLIENT_NAME $AUTH_ARGS -y
# Create the client/node
run_cmd knife client create $TEST_CLIENT_NAME $AUTH_ARGS -d -f /tmp/client.pem
run_cmd knife node create $TEST_CLIENT_NAME $AUTH_ARGS -d

echo "Uploading the test cookbook"
run_cmd knife cookbook upload test_upload $AUTH_ARGS || PROXY_TEST_RESULT=failed

# Run chef-client
echo "Running chef-client ..."
run_cmd timeout 120 chef-client -c $PROXY_TESTS_REPO/.chef/knife.rb -N $TEST_CLIENT_NAME --client_key /tmp/client.pem -o test || PROXY_TEST_RESULT=failed

echo "Testing 'knife ssl'"
run_cmd timeout -k 20 -s 9 20 knife ssl check $AUTH_ARGS || PROXY_TEST_RESULT=failed
run_cmd timeout -k 20 -s 9 20 knife ssl fetch $AUTH_ARGS || PROXY_TEST_RESULT=failed

# Testing knife commands
echo "Testing knife commands"
run_cmd knife role from file $PROXY_TESTS_REPO/roles/test_upload.json $AUTH_ARGS || PROXY_TEST_RESULT=failed
run_cmd knife show roles/test_upload.json $AUTH_ARGS --chef-repo-path . || PROXY_TEST_RESULT=failed
