# See tk_env_test.rb

raise "ENV['HTTP_PROXY'] = #{ENV['HTTP_PROXY']}" unless ENV['HTTP_PROXY'] == "http://127.0.0.1:3128"
raise "ENV['HTTPS_PROXY'] = #{ENV['HTTPS_PROXY']}" unless ENV['HTTPS_PROXY'] == "http://127.0.0.1:3128"
#raise "ENV['FTP_PROXY'] = #{ENV['FTP_PROXY']}" unless ENV['FTP_PROXY'] == "http://127.0.0.1:3128"
raise "ENV['NO_PROXY'] = #{ENV['NO_PROXY']}" unless ENV['NO_PROXY'] == nil
