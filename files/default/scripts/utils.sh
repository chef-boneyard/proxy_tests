ALL_PROXY_VARIABLES="http_proxy https_proxy ftp_proxy no_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY NO_PROXY"
reset_test_environment() {
  echo "Unsetting all proxy environment variables ..."
  for v in $ALL_PROXY_VARIABLES
  do
    unset $v
    export $v
  done
  echo "Commenting out set_proxy_config in $PROXY_TESTS_REPO/.chef/knife.rb ..."
  sed -i "s/^set_proxy_config/#set_proxy_config/g" $PROXY_TESTS_REPO/.chef/knife.rb
}

run_cmd() {
  echo ""
  echo "Running $* ..."
  $*
}
