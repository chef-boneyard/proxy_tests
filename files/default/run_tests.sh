#!/bin/sh
TESTS="${1:-*}"
PROXIES="${2:-*}"
CONFIGURATIONS="${3:-*}"

# Find where PROXY_TESTS_DIR is being run from
PROXY_TESTS_DIR="${PROXY_TESTS_DIR:-$(dirname $(dirname $(dirname $0)))}"
echo Running tests from $PROXY_TESTS_DIR ...

# Make any failing command fail the whole thing
set -e

for test_script in $PROXY_TESTS_DIR/files/default/tests/$TESTS.sh
do
  TEST="$(basename ${test_script%%.*})"
  echo ""
  echo "===================================================="
  echo "Test $TEST"
  echo "===================================================="

  for proxy_dir in $PROXY_TESTS_DIR/files/default/proxies/$PROXIES
  do
    PROXY="$(basename $proxy_dir)"
    echo ""
    echo "===================================================="
    echo "Proxy $PROXY (test $TEST)"
    echo "===================================================="
    echo "Running $proxy_dir/start.sh ..."
    source $proxy_dir/start.sh

    for configuration_script in $PROXY_TESTS_DIR/files/default/proxies/$PROXY/configurations/$CONFIGURATIONS.sh
    do
      CONFIGURATION="$(basename ${configuration_script%%.*})"
      echo ""
      echo "===================================================="
      echo "Configuration $CONFIGURATION (test $TEST, proxy $PROXY)"
      echo "===================================================="
      echo "Running $configuration_script ..."
      source $configuration_script

      echo "Running $test_script ..."
      source $test_script
    done
  done
done
