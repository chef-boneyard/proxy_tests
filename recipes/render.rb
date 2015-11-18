remote_directory ENV['PROXY_TESTS_DIR'] do
  source 'scripts'
end
if node[:os] == "darwin"
  remote_directory ENV['PROXY_TESTS_DIR'] do
    source "scripts_#{node[:os]}"
  end
end
