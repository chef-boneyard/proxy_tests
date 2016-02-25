# -*- mode: ruby -*-
# vi: set ft=ruby :

unless ENV['CHEF_DEV_REPOS_DIR']
  abort "Set the CHEF_DEV_REPOS_DIR environment variable to point to your repos directory."
end

Vagrant.configure(2) do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.box = "bento/ubuntu-14.04"

  config.vm.synced_folder ".", "/opt/proxy_tests", create: true
  # config.vm.synced_folder "/Users/tball/github/berkshelf", "/opt/berkshelf", create: true
  # config.vm.synced_folder "/Users/tball/github/test-kitchen", "/opt/test-kitchen", create: true
  config.vm.synced_folder "#{ENV['CHEF_DEV_REPOS_DIR']}/chef", "/opt/chef", create: true

  config.vm.provision "shell", inline: "sudo apt-get update"
  config.vm.provision "shell", inline: "sudo apt-get -y install squid3 git curl wget vim"
  config.vm.provision "shell", inline: "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3", privileged: false
  # config.vm.provision "shell", inline: "curl -sSL https://get.rvm.io | bash -s stable", privileged: false
end
