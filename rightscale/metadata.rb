maintainer       "RightScale, Inc."
maintainer_email "graham@rightscale.com"
license          "Apache 2.0"
description      "Patches to rightscale stuff"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.2"

recipe "rightscale::right_popen", "Upgrades right_popen to version 1.0.11"
recipe "rightscale::abuse_emacs", "Uninstall and install emacs"
recipe "rightscale::abuse_xmldevel", "Uninstall and install libxml2-devel"
recipe "rightscale::abuse_centos", "Uninstall and install xml stuff"
