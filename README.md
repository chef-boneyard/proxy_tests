This repository contains the tests we do to find out whether proxies work with various Chef software. Instructions for doing the various bits:

# OS Variants

## Vagrant Linux

1. Install VirtualBox and Vagrant.
2. vagrant up

# Tests

To run a test, decide on a test, proxy, and configuration, and call `run_test.sh`. For example, to run the install_sh against a real proxy with :

```ruby
vagrant ssh -c "sudo sh /opt/proxy_tests/files/default/run_test.sh install_sh no_proxy env_http_only"
```

The list of proxy types are in /opt/proxy_tests/files/default/proxies. They include:

- single (http, https and ftp are all the same proxy)
- separate (http, https and ftp are all separate proxies)
- none (proxy is shut down)

The list of configuration types are in /opt/proxy_tests/files/default/<proxy type>/configurations. They assume environment variables will be set by the proxy that will allow them to do their configuration correctly.

The list of tests are in /opt/proxy_tests/files/tests. Tests include:

- install_sh (runs `curl https://www.chef.io/chef/install.sh | bash -S`)

## Proxies

The To bring up different proxy configurations, run one of the proxy start.sh scripts:

1. Single Proxy Handling Everything: `vagrant ssh -c "sudo sh /opt/proxy_tests/files/default/single_proxy/start.sh`
2. No Proxy: `vagrant ssh -c "sudo sh /opt/proxy_tests/files/default/no_proxy/start.sh`
