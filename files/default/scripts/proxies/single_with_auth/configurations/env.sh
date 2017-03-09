reset_test_environment

echo "Setting http_proxy, https_proxy and ftp_proxy to http://127.0.0.1:3128 ..."
http_proxy=http://proxy:proxy@127.0.0.1:3128
https_proxy=http://proxy:proxy@127.0.0.1:3128
ftp_proxy=http://proxy:proxy@127.0.0.1:3128
export http_proxy
export https_proxy
export ftp_proxy

export TK_SUITE_NAME=env
