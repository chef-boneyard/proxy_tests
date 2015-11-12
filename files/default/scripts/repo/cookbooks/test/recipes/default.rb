# Purge the /tmp/test directory
directory '/tmp/test' do
  action :delete
  recursive true
end
directory '/tmp/test'

# https
remote_file '/tmp/test/https.txt' do
  source 'https://chef.io/chef/install.sh'
end

# http
remote_file '/tmp/test/http.txt' do
  source 'http://chef.io/chef/install.sh'
end

# ftp
# remote_file '/tmp/test/ftp.txt' do
#   source 'ftp://ftp.gnu.org/welcome.msg'
# end

# git
git '/tmp/test/sudo' do
  repository 'https://github.com/chef-cookbooks/sudo.git'
end
