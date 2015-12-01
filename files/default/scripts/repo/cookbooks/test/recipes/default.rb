# Purge the /tmp/test directory
directory '/tmp/test' do
  action :delete
  recursive true
end
directory '/tmp/test'

# https
remote_file '/tmp/test/https.txt' do
  source 'https://raw.githubusercontent.com/chef/chef/master/.rspec'
end

# http
remote_file '/tmp/test/http.txt' do
  source 'http://ftp.gnu.org/welcome.msg'
end

# ftp
# remote_file '/tmp/test/ftp.txt' do
#   source 'ftp://ftp.gnu.org/welcome.msg'
# end

# git
git '/tmp/test/sudo' do
  repository 'https://github.com/chef-cookbooks/sudo.git'
end

package "subversion"

# SVN
directory '/tmp/test/couchdb'
subversion '/tmp/test/couchdb' do
  repository 'http://svn.apache.org/repos/asf/couchdb/trunk'
  # The subversion resource doesn't respect env variables right now
  # TODO fix this
  action :nothing
end

chef_gem 'retryable' do
  version '1.2'
  compile_time false
end

gem_package 'retryable' do
  version '1.2.1'
end

execute "curl works" do
  command "curl 'https://omnitruck.chef.io/install.sh' -d /tmp/test/curl.out"
end

execute "wget works" do
  command "wget 'https://omnitruck.chef.io/install.sh' -o /tmp/test/wget.out"
end

# https://www.jethrocarr.com/2014/08/14/ruby-nethttp-proxies/
# Must use `Net::HTTP.new` to get environment variables
ruby_block "Net::HTTP test" do
  block {
    puts ENV.inspect
    require 'net/http'
    require 'uri'
    uri       = URI('http://www.chef.io/')
    request   = Net::HTTP.new(uri.host, uri.port)
    response  = request.get(uri)
    raise RuntimeError unless response.response.code.to_i == 301
    uri       = URI('https://www.chef.io/')
    request   = Net::HTTP.new(uri.host, uri.port)
    request.use_ssl = true
    response  = request.get(uri)
    raise RuntimeError unless response.body =~ /Chef Software, Inc/
  }
end
