#!/bin/bash

BERKSHELF_TESTS_DIR=$PROXY_TESTS_DIR/tests/berkshelf

# Clear the berkshelf
run_cmd rm -rf ~/.berkshelf

# Attempt a berks install using the sample Berksfile
run_cmd berks install --berksfile=$BERKSHELF_TESTS_DIR/Berksfile || PROXY_TEST_RESULT=failed

# Attempt to do a berks upload to a Chef server.
#
# This requires doing a berks install to get everything resolved.
#
# We don't need to authenticate successfully, just check to see if we got a 401
# response. If we get this response it means we connected successfully through
# the proxy.
run_cmd berks install --berksfile=$BERKSHELF_TESTS_DIR/Berksfile && berks upload --config=$BERKSHELF_TESTS_DIR/config.json --berksfile=$BERKSHELF_TESTS_DIR/Berksfile | grep HTTPForbidden || PROXY_TEST_RESULT=failed
