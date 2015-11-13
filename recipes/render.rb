remote_directory ENV['PROXY_TESTS_DIR'] do
  source 'scripts'
end
remote_directory ENV['PROXY_TESTS_DIR'] do
  source "scripts_#{node[:os]}"
end
