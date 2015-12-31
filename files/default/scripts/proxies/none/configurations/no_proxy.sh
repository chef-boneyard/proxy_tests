reset_test_environment

echo "Setting http_proxy, https_proxy and ftp_proxy to http://127.0.0.1:3128 ..."
http_proxy="http://127.0.0.1:3128"
https_proxy="http://127.0.0.1:3128"
ftp_proxy="http://127.0.0.1:3128"
no_proxy=www.chef.io,*.ubuntu.com,github.com,ftp.gnu.org,raw.githubusercontent.com,s3-external-1.amazonaws.com,api.chef.io,omnitruck.chef.io,getchef.com,opscode.com,opscode-omnibus-packages.s3.amazonaws.com,rubygems.org,rubygems.global.ssl.fastly.net
echo "Set no_proxy to $no_proxy"
export http_proxy
export https_proxy
export ftp_proxy
export no_proxy

export TK_SUITE_NAME=no_proxy
