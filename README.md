This repository contains the tests we do to find out whether proxies work with various Chef software. Instructions for doing the various bits:

# OS Variants

## Vagrant Linux

1. Install VirtualBox and Vagrant.
2. vagrant up

# Running Tests

To run all tests, run `run_tests.sh` with no arguments:

```ruby
vagrant ssh -c "sudo /opt/proxy_tests/files/default/run_tests.sh"
```

To run one test or one set of tests, add arguments of the form `run_tests.sh TEST PROXY CONFIGURATION`. Wildcards are allowed. For example:

```ruby
# Run just the single-proxy install.sh test, with all env variables set
vagrant ssh -c "sudo /opt/proxy_tests/files/default/run_tests.sh install_sh single env"
# Run all install_sh tests
vagrant ssh -c "sudo /opt/proxy_tests/files/default/run_tests.sh install_sh"
```

```ruby
# Run just the single-proxy install.sh test, with all env variables set
vagrant ssh -c "/opt/proxy_tests/files/default/run_tests.sh install_sh single env"
# Run all tests against the single-proxy
vagrant ssh -c "/opt/proxy_tests/files/default/run_tests.sh \* single"
# Run all tests that set all environment variables, no matter what the proxy
vagrant ssh -c "/opt/proxy_tests/files/default/run_tests.sh \* \* env"
```
