default[:rvm][:releases] = "https://rvm.beginrescueend.com/releases/"
default[:rvm][:version] = open("#{node[:rvm][:releases]}/latest-version.txt").read.chomp
default[:rvm][:rubies] = ["1.8.7", "1.9.2"]
