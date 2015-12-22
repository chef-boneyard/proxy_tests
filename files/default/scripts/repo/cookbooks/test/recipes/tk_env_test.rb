# Running `kitchen verify` with proxy settings on the TK workstation tries to
# run busser on the target machine with the same proxy settings.  Unless that
# machine actually has a proxy setup, busser will fail trying to install plugins.

# Instead we run a recipe that has the actual assertions we care about in it.

raise "ENV['http_proxy'] = #{ENV['http_proxy']}" unless ENV['http_proxy'] == "http://127.0.0.1:3128"
raise "ENV['https_proxy'] = #{ENV['https_proxy']}" unless ENV['https_proxy'] == "http://127.0.0.1:3128"
raise "ENV['ftp_proxy'] = #{ENV['ftp_proxy']}" unless ENV['ftp_proxy'] == "http://127.0.0.1:3128"
raise "ENV['no_proxy'] = #{ENV['no_proxy']}" unless ENV['no_proxy'] == nil
