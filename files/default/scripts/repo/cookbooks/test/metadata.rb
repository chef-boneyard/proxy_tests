name 'test'
version '1.0.0'
description <<-DESC
This cookbook servers multiple purposes.  The default recipe is made to be run
on a locked down system to test that the Chef Resources respect the different
proxy settings.  It also contains Test Kitchen configuration to test that remote
machine managed by TK can converge those same resources when it is locked down
and TK has the proper proxy settings.
DESC

maintainer 'John Keiser'
maintainer_email 'jkeiser@chef.io'
