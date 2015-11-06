# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "opscode-centos-7.0"

  config.vm.synced_folder ".", "/opt/proxy_tests", create: true

  config.vm.provision "shell", inline: <<-END_SHELL
    sudo yum install -y squid git
    route add -net 127.0.0.0 netmask 255.0.0.0 dev lo
    sudo bash /opt/proxy_tests/files/default/install_chefdk.sh
  END_SHELL
end
