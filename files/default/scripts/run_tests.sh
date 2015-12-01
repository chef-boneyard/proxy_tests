#!/bin/bash
TESTS="${1:-*}"
PROXIES="${2:-*}"
CONFIGURATIONS="${3:-*}"
RESULTS_FILE=$4

# Print out header to results file
[ $RESULTS_FILE ] && (echo "# Test,Proxy,Configuration,Result" > $RESULTS_FILE)

PROXY_TESTS_DIR=$(dirname $0)
echo "Running tests from $PROXY_TESTS_DIR ..."

# Bring in the utility functions
. $PROXY_TESTS_DIR/utils.sh

test_is_pending() {
  echo "test_is_pending $1 $2 $3"
  [[ ( ( $1 == "berkshelf" || $1 == "chef_client" ) && $3 == "no_proxy" ) || ( $1 == "install_sh" && $3 == "env_upper") || ( $1 == "chef_client" && $2 == "single" && $3 == "env_upper" ) ]]
}

# Make any failing command fail the whole thing
set -e

# Start out assuming all our tests are going to succeed
FINAL_EXIT_CODE=0

for proxy_dir in $PROXY_TESTS_DIR/proxies/$PROXIES
do
  PROXY="$(basename $proxy_dir)"
  echo ""
  echo "========================================"
  echo "Proxy $PROXY"
  echo "========================================"
  echo "Running $proxy_dir/start.sh ..."
  . $proxy_dir/start.sh

  for test_script in $PROXY_TESTS_DIR/tests/$TESTS.sh
  do
    TEST="$(basename $test_script .sh)"
    echo ""
    echo "===================="
    echo "Proxy $PROXY - Test $TEST"
    echo "===================="

    for configuration_script in $PROXY_TESTS_DIR/proxies/$PROXY/configurations/$CONFIGURATIONS.sh
    do
      CONFIGURATION="$(basename $configuration_script .sh)"
      if test_is_pending "$TEST" "$PROXY" "$CONFIGURATION"; then
        echo "SKIPPING - pending"
      else
        echo ""
        echo "============================================================"
        echo "Test $TEST - Proxy $PROXY - Configuration $CONFIGURATION"
        echo "============================================================"
        echo "Running $configuration_script ..."
        . $configuration_script

        echo "Running $test_script ..."
        PROXY_TEST_RESULT="succeeded"
        # Turn off immediate-error-exiting for the duration of the test
        set +e
        . $test_script
        set -e
        echo ""
        echo ">>>>>>> $PROXY_TEST_RESULT"
        echo ""

        [[ $PROXY_TEST_RESULT == "failed" ]] && FINAL_EXIT_CODE=1;

        # Print result to results file
        [ $RESULTS_FILE ] && (echo "$TEST,$PROXY,$CONFIGURATION,$PROXY_TEST_RESULT" >> $RESULTS_FILE)
      fi
    done
  done
done

exit $FINAL_EXIT_CODE
