reset_test_environment

echo "Uncommenting set_proxy_config in $PROXY_TESTS_REPO/.chef/knife.rb ..."
sed -i "s/^#set_proxy_config/set_proxy_config/g" $PROXY_TESTS_REPO/.chef/knife.rb

export TK_SUITE_NAME=client_rb
