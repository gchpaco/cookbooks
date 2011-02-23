# Cookbook Name:: rightscale
# Recipe:: abuse_xmldevel
package "libxml2-devel" do
  action :remove
end
package "libxml2-devel" do
  action :purge
end
package "libxml2-devel"
