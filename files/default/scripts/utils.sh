ALL_PROXY_VARIABLES="http_proxy https_proxy ftp_proxy no_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY NO_PROXY"
unset_proxy_variables() {
  echo "Unsetting all proxy environment variables ..."
  for v in $ALL_PROXY_VARIABLES
  do
    unset $v
    export $v
  done
}

run_cmd() {
  echo ""
  echo "Running $* ..."
  $*
}
