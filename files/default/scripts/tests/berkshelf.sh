#!/bin/bash
# Clear the berkshelf
run_cmd rm -rf ~/.berkshelf

# Install apache2
run_cmd timeout -k 60 -s 9 60 berks install -b $PROXY_TESTS_DIR/tests/berkshelf/Berksfile || PROXY_TEST_RESULT=failed
