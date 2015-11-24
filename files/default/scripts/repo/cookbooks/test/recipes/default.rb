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

# TODO does execute run a remote script?

ruby_block "Net::HTTP test" do
  block {
    puts ENV.inspect
    require 'net/http'
    require 'uri'
    http = Net::HTTP.get(URI('http://chef.io/'))
    raise RuntimeError unless http =~ /301/
    https = Net::HTTP.get(URI('https://www.chef.io/'))
    raise RuntimeError unless https =~ /Chef Software, Inc/
  }
  # TODO This doesn't actually work yet! Tracking it down separately.
  action :nothing
end
