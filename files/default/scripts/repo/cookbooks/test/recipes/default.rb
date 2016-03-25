# Purge the /tmp/test_proxy_dir directory
directory '/tmp/test_proxy_dir' do
  action :delete
  recursive true
end
directory '/tmp/test_proxy_dir'

# https
remote_file '/tmp/test_proxy_dir/https.txt' do
  source 'https://raw.githubusercontent.com/chef/chef/master/.rspec'
end

# http
remote_file '/tmp/test_proxy_dir/http.txt' do
  source 'http://ftp.gnu.org/welcome.msg'
end

# ftp
# remote_file '/tmp/test_proxy_dir/ftp.txt' do
#   source 'ftp://ftp.gnu.org/welcome.msg'
# end

# git
package "git"
git '/tmp/test_proxy_dir/sudo' do
  repository 'https://github.com/chef-cookbooks/sudo.git'
end

package "subversion"

# SVN
directory '/tmp/test_proxy_dir/couchdb'
subversion '/tmp/test_proxy_dir/couchdb' do
  repository 'http://svn.apache.org/repos/asf/couchdb/trunk'
  action :sync
end

directory '/tmp/test_proxy_dir/style'
subversion 'style' do
  repository 'https://svn.code.sf.net/p/astyle/code/trunk/AStyle'
  action :sync
end

chef_gem 'retryable' do
  version '1.2'
  compile_time false
end

gem_package 'retryable' do
  version '1.2.1'
end

execute "curl works" do
  command "curl 'https://omnitruck.chef.io/install.sh' -d /tmp/test_proxy_dir/curl.out"
end

execute "wget works" do
  command "wget 'https://omnitruck.chef.io/install.sh' -o /tmp/test_proxy_dir/wget.out"
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
