This repository contains the tests we do to find out whether proxies work with various Chef software. Instructions for doing the various bits:

[![Build Status](https://travis-ci.org/chef/proxy_tests.svg?branch=master)](https://travis-ci.org/chef/proxy_tests)

# OS Variants

## Vagrant Linux

1. Install VirtualBox and Vagrant.
2. vagrant up

# Running Tests

To run all tests, run `run_tests.sh` with no arguments:

```ruby
vagrant ssh -c "sudo /opt/proxy_tests/files/default/scripts/run_tests.sh"
```

To run one test or one set of tests, add arguments of the form `run_tests.sh TEST PROXY CONFIGURATION`. Wildcards are allowed. For example:

```ruby
# Run just the single-proxy install.sh test, with all env variables set
vagrant ssh -c "sudo /opt/proxy_tests/files/default/scripts/run_tests.sh install_sh single env"
# Run all install_sh tests
vagrant ssh -c "sudo /opt/proxy_tests/files/default/scripts/run_tests.sh install_sh"
```

```ruby
# Run just the single-proxy install.sh test, with all env variables set
vagrant ssh -c "/opt/proxy_tests/files/default/scripts/run_tests.sh install_sh single env"
# Run all tests against the single-proxy
vagrant ssh -c "/opt/proxy_tests/files/default/scripts/run_tests.sh \* single"
# Run all tests that set all environment variables, no matter what the proxy
vagrant ssh -c "/opt/proxy_tests/files/default/scripts/run_tests.sh \* \* env"
```

(chef_client|berkshelf|kitchen|install_sh) (single|none) (client_rb|env|env_upper|no_proxy)

`no_proxy` is an odd case: it only works with `none`, because we _don't_ start a proxy on the box, but _do_ set `no_proxy` to equal various domains, and then we try to access those domains, which will only work if we're handling `no_proxy` correctly.

### Results

The results so far:

| Test        | Configuration    | Result    |
|-------------|------------------|-----------|
| berkshelf   | env vars         | succeeded |
| chef_client | env vars         | succeeded |
| install_sh  | env vars         | succeeded |
| kitchen     | env vars         | succeeded |
| berkshelf   | env vars (upper) | succeeded |
| chef_client | env vars (upper) | succeeded |
| install_sh  | env vars (upper) | succeeded |
| kitchen     | env vars (upper) | succeeded |
| berkshelf   | no_proxy         | failed    |
| chef_client | no_proxy         | failed    |
| install_sh  | no_proxy         | succeeded |
| kitchen     | no_proxy         | succeeded |
