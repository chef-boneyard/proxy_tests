#!/bin/bash

# We must execute the kitchen commands from the cookbook directory
cwd=$(pwd)
cd $PROXY_TESTS_REPO/cookbooks/test

echo "Setting up kitchen instances"
run_cmd kitchen create -c 5 || PROXY_TEST_RESULT=failed

echo "Running the tests on the target instance"
run_cmd kitchen verify -c 5 || PROXY_TEST_RESULT=failed

echo "Destroying instances once done"
run_cmd kitchen destroy -c 5 || PROXY_TEST_RESULT=failed

cd $cwd
