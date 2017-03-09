# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.box = "bento/ubuntu-14.04"

  config.vm.synced_folder ".", "/opt/proxy_tests", create: true
  # config.vm.synced_folder "/Users/tduffield/github/berkshelf/berkshelf", "/opt/berkshelf", create: true
  # config.vm.synced_folder "/Users/tduffield/github/test-kitchen/test-kitchen", "/opt/test-kitchen", create: true
  # config.vm.synced_folder "/Users/tduffield/github/chef/chef", "/opt/chef", create: true
  # config.vm.synced_folder "/Users/tduffield/github/chef/ohai", "/opt/ohai", create: true

  config.vm.provision "shell", inline: "sudo apt-get update"
  config.vm.provision "shell", inline: "sudo apt-get -y install squid3 git curl wget vim apache2-utils g++"
  config.vm.provision "shell", inline: "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3", privileged: false
  config.vm.provision "shell", inline: "sudo htpasswd -b -c /etc/squid3/passwords proxy proxy"
  config.vm.provision "shell", inline: "curl -sSL https://get.rvm.io | bash -s stable", privileged: true
end
