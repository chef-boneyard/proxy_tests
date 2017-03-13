This repository contains the tests we do to find out whether proxies work with various Chef software. Instructions for doing the various bits:

# OS Variants

## Vagrant Linux

1. Install VirtualBox and Vagrant.
2. vagrant up

# Running Tests

# Login Steps

    vagrant ssh
    sudo -i

    root@vagrant:~$ cd /opt/proxy_tests/files/default/scripts
    root@vagrant:/opt/proxy_tests/files/default/scripts$ export PROXY_TESTS_DIR="$(pwd)"
    root@vagrant:/opt/proxy_tests/files/default/scripts$ export PROXY_TESTS_REPO="$PROXY_TESTS_DIR/repo"

To run all tests, run `run_tests.sh` with no arguments:

    root@vagrant:/opt/proxy_tests/files/default/scripts$ ./run_tests.sh

## Testing Local Code

Modify the Vagrantfile to sync your local code to the VM. There should be commented out examples that you can use to get started. If you modify that file, simply run `vagrant reload`, then repeat the "Login Steps".

Next, if you need to compile your code, install Ruby via RVM:

    root@vagrant:~$ rvm install 2.3.1
    root@vagrant:~$ gem install bundler

## Testing Specific Tools

To run one test or one set of tests, add arguments of the form `run_tests.sh TEST PROXY CONFIGURATION`. Wildcards are allowed. For example:

    # Run just the single-proxy install.sh test, with all env variables set
    root@vagrant:/opt/proxy_tests/files/default/scripts$ ./run_tests.sh install_sh single env

    # Run all install_sh tests
    root@vagrant:/opt/proxy_tests/files/default/scripts$ ./run_tests.sh install_sh


    # Run just the single-proxy install.sh test, with all env variables set
    root@vagrant:/opt/proxy_tests/files/default/scripts$ ./run_tests.sh install_sh single env

    # Run all tests against the single-proxy
    root@vagrant:/opt/proxy_tests/files/default/scripts$ ./run_tests.sh \* single

    # Run all tests that set all environment variables, no matter what the proxy
    root@vagrant:/opt/proxy_tests/files/default/scripts$ ./run_tests.sh \* \* env


## Troubleshooting

  1. I can't download anything!
     Run `iptables -F OUTPUT` to reset the IP Tables
