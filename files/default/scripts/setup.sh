sudo yum install -y squid git
route add -net 127.0.0.0 netmask 255.0.0.0 dev lo
sudo bash /opt/proxy_tests/files/default/install_chefdk.sh
