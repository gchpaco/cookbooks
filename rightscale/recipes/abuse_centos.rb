# Cookbook Name:: rightscale
# Recipe:: abuse_centos

bash "setup for fail" do
  code <<-EOH
    yum -y erase libxml2-devel libxslt-devel
  EOH
end

["libxml2-devel", "libxslt-devel"].each { |p| package p } 

