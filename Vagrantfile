# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "bento/ubuntu-14.04"

  config.vm.synced_folder ".", "/opt/proxy_tests", create: true

  #config.vm.provision "shell", inline: "/opt/proxy_tests/files/default/scripts/setup.sh"
end
