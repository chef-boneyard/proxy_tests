puts node['platform_family']
puts node['platform']
remote_directory ENV['PROXY_TESTS_DIR'] do
  source 'scripts'
end
