reset_test_environment

echo "Setting http_proxy, https_proxy and ftp_proxy to http://127.0.0.1:3128 ..."
http_proxy="http://127.0.0.1:3128"
https_proxy="http://127.0.0.1:3128"
ftp_proxy="http://127.0.0.1:3128"
echo "Setting no_proxy to .chef.io,.getchef.com,.opscode.com,.s3.amazonaws.com,.rubygems.org"
no_proxy=.chef.io,.getchef.com,.opscode.com,.s3.amazonaws.com,.rubygems.org
export http_proxy
export https_proxy
export ftp_proxy
export no_proxy
