#!/bin/sh
TESTS="${1:-*}"
PROXIES="${2:-*}"
CONFIGURATIONS="${3:-*}"
RESULTS_FILE=$4

# Print out header to results file
[ $RESULTS_FILE ] && (echo "# Test,Proxy,Configuration,Result" > $RESULTS_FILE)

# Find where PROXY_TESTS_DIR is being run from
PROXY_TESTS_DIR="${PROXY_TESTS_DIR:-$(dirname $(dirname $(dirname $0)))}"
echo "Running tests from $PROXY_TESTS_DIR ..."

# Bring in the utility functions
source $PROXY_TESTS_DIR/files/default/utils.sh

# Make any failing command fail the whole thing
set -e

for proxy_dir in $PROXY_TESTS_DIR/files/darwin/proxies/$PROXIES
do
  PROXY="$(basename $proxy_dir)"
  echo ""
  echo "========================================"
  echo "Proxy $PROXY"
  echo "========================================"
  echo "Running $proxy_dir/start.sh ..."
  source $proxy_dir/start.sh

  for test_script in $PROXY_TESTS_DIR/files/default/tests/$TESTS.sh
  do
    TEST="$(basename $test_script)"
    echo ""
    echo "===================="
    echo "Proxy $PROXY - Test $TEST"
    echo "===================="

    for configuration_script in $PROXY_TESTS_DIR/files/default/proxies/$PROXY/configurations/$CONFIGURATIONS.sh
    do
      CONFIGURATION="$(basename $configuration_script)"
      echo ""
      echo "============================================================"
      echo "Test $TEST - Proxy $PROXY - Configuration $CONFIGURATION"
      echo "============================================================"
      echo "Running $configuration_script ..."
      source $configuration_script

      echo "Running $test_script ..."
      PROXY_TEST_RESULT=succeeded
      # Turn off immediate-error-exiting for the duration of the test
      set +e
      source $test_script
      set -e
      echo ""
      echo ">>>>>>> $PROXY_TEST_RESULT"
      echo ""

      # Print result to results file
      [ $RESULTS_FILE ] && (echo "$TEST,$PROXY,$CONFIGURATION,$PROXY_TEST_RESULT" >> $RESULTS_FILE)
    done
  done
done
