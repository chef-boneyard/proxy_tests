# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "opscode-centos-7.0"

  config.vm.synced_folder ".", "/opt/proxy_tests", create: true

  config.vm.provision "shell", inline: "/opt/proxy_tests/files/default/setup.sh"
end
