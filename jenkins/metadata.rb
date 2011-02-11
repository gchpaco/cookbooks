maintainer "Graham Hughes"
maintainer_email "graham@rightscale.com"
license "MIT"
description "Install and run Jenkins on Ubuntu/Debian"
version "0.2"
depends "apt"
depends "nginx"
supports "ubuntu"
supports "debian"

recipe "jenkins::repository", "Sets up Jenkins repository"
recipe "jenkins::update", "Updates Jenkins instance"
recipe "jenkins::shutdown", "Shuts the Jenkins instance down"
recipe "jenkins", "Starts local Jenkins master"
recipe "jenkins::nginx", "Starts nginx proxy for local Jenkins server"

attribute "jenkins/port",
  :display_name => "Jenkins local port",
  :description => "Port for Jenkins server to listen on",
  :default => "8080"
