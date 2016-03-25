This repository contains the tests we do to find out whether proxies work with various Chef software. Instructions for doing the various bits:

[![Build Status](https://travis-ci.org/chef/proxy_tests.svg?branch=master)](https://travis-ci.org/chef/proxy_tests)

# OS Variants

## Vagrant Linux

1. Install VirtualBox and Vagrant.
2. vagrant up

# Running Tests

These tests run natively in Travis, and are run continuously from `chef/chef`. The `run_tests.sh` script targets Travis (and does not run inside Vagrant), but this document will assume you're running inside a Vagrant VM, which uses the `run_in_vagrant.sh` script, but takes the same arguments as `run.sh` (though with different defaults).

```
| Test                       | (chef_client|berkshelf|kitchen|install_sh) |
| Proxies to set up          | (single|none)                              |
| Proxy configuration source | (client_rb|env|env_upper|no_proxy)         |
```

By default, this will test `chef_client` with no proxy (`none`) 

```shell
cd /opt/proxy_tests && ./run_in_vagrant.sh
```

To run one test or one set of tests, add arguments of the form `run_tests.sh TEST PROXY CONFIGURATION`. Wildcards are allowed. For example:

```shell
# Run just the single-proxy install.sh test, with all env variables set
cd /opt/proxy_tests && ./run_in_vagrant.sh install_sh single env

# Run all install_sh tests
cd /opt/proxy_tests && ./run_in_vagrant.sh install_sh
```

```shell
# Run just the single-proxy install.sh test, with all env variables set
cd /opt/proxy_tests && ./run_in_vagrant.sh install_sh single env"

# Run all tests against the single-proxy
cd /opt/proxy_tests && ./run_in_vagrant.sh \* single"

# Run all tests that set all environment variables, no matter what the proxy
cd /opt/proxy_tests && ./run_in_vagrant.sh \* \* env"
```


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
