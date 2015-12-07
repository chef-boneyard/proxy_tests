remote_directory ENV['PROXY_TESTS_DIR'] do
  source 'scripts'
end
if node[:os] == "darwin"
  remote_directory ENV['PROXY_TESTS_DIR'] do
    source "scripts_#{node[:os]}"
  end
end

# Berkshelf needs a config.json with an absolute path to the client key. Write
# it out.
file "#{ENV['PROXY_TESTS_DIR']}/tests/berkshelf/config.json" do
  content JSONCompat.to_json_pretty "chef" => {
    "chef_server_url" => "https://api.chef.io/organizations/chef_proxy_tests",
    "client_key" => "#{ENV['PROXY_TESTS_REPO']}/.chef/client-creator.pem",
    "node_name" => "client-creator",
  }
end
