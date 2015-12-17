chef_repo_path           File.expand_path("../..", __FILE__)
chef_server_url          "https://api.chef.io/organizations/chef_proxy_tests"
#node_name                "jkeiser"
#client_key               File.expand_path("~/.chef/keys/jkeiser.pem") if File.exist?(File.expand_path("~/.chef/keys/jkeiser.pem"))

# Adding a method that handles setting the chef config for proxies.
# Then single tests or configurations can call this if they want to
# set these configs.  It assumes we are using the local squid proxy.
def set_proxy_config
  http_proxy  "http://127.0.0.1:3128"
  https_proxy "http://127.0.0.1:3128"
  ftp_proxy   "http://127.0.0.1:3128"
end

#set_proxy_config
