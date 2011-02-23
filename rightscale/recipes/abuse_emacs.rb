# Cookbook Name:: rightscale
# Recipe:: abuse_emacs
package "emacs" do
  action :remove
end
package "emacs" do
  action :purge
end
package "emacs"
