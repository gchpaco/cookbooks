maintainer "Graham Hughes"
maintainer_email "graham@rightscale.com"
license "MIT"
description "Install RVM"
version "0.1"
depends "apt"

recipe "rvm", "Install RVM"
recipe "rvm::install", "Install RVM"
recipe "rvm::install_rubies", "Install various Ruby implementations"

attribute "rvm/homedir", :display_name => "RVM home directory",
  :description => "Directory to install RVM to",
  :default => "/var/lib/rvm"
attribute "rvm/user", :display_name => "RVM user",
  :description => "User to run RVM as",
  :default => "root"
attribute "rvm/group", :display_name => "RVM group",
  :description => "Group to run RVM as",
  :default => "root"
attribute "rvm/releases", :display_name => "RVM releases URL",
  :description => "URL to download RVM releases from",
  :default => "https://rvm.beginrescueend.com/releases/"
attribute "rvm/version", :display_name => "RVM version",
  :description => "RVM version to use",
  :default => "1.6.0"
attribute "rvm/rubies", :display_name => "Rubies to install",
  :description => "Which ruby versions to install",
  :default => "1.6.0"
