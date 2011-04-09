#--  -*- mode: ruby; encoding: utf-8 -*-
# Copyright: Copyright (c) 2011 RightScale, Inc.
# Cookbook Name:: rvm
# Recipe:: install
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# 'Software'), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

require 'digest/md5'
require 'shellwords'

rvmdir = node[:rvm][:homedir]
rvmarchivesdir = File.join(rvmdir, "archives")
rvmsrcdir = File.join(rvmdir, "src")

[rvmdir, rvmarchivesdir, rvmsrcdir].each {|dir|
  directory dir do
    owner "#{node[:rvm][:user]}"
    group "#{node[:rvm][:group]}"
    mode "0755"
    action :create
  end
end

remote_file "#{rvmarchivesdir}/rvm-#{node[:rvm][:version]}.tar.gz" do
  source "#{node[:rvm][:releases]}/rvm-#{node[:rvm][:version]}.tar.gz"
  mode "0644"
  action :create_if_missing
end

remote_file "#{rvmarchivesdir}/rvm-#{node[:rvm][:version]}.tar.gz.md5" do
  source "#{node[:rvm][:releases]}/rvm-#{node[:rvm][:version]}.tar.gz.md5"
  mode "0644"
  action :create_if_missing
end

ruby_block "check_md5_checksum" do
  block do
    digest = Digest::MD5.new
    File.open("#{rvmarchivesdir}/rvm-#{node[:rvm][:version]}.tar.gz") do |f|
      digest << f.read(4096)
    end
    claimed_md5 = File.open("#{rvmarchivesdir}/rvm-#{node[:rvm][:version]}.tar.gz.md5").read.chomp
    if digest.hexdigest != claimed_md5
      FileUtils.rm("#{rvmarchivesdir}/rvm-#{node[:rvm][:version]}.tar.gz")
      FileUtils.rm("#{rvmarchivesdir}/rvm-#{node[:rvm][:version]}.tar.gz.md5")
      raise "MD5 checksum for #{rvmarchivesdir}/rvm-#{node[:rvm][:version]}.tar.gz differs from claimed"
    end
  end
  action :create
end

execute "tar" do
  command "tar zoxf #{Shellwords.escape(rvmarchivesdir)}/rvm-#{Shellwords.escape(node[:rvm][:version])}.tar.gz -C #{Shellwords.escape(rvmsrcdir)}"
  user node[:rvm][:user]
  group node[:rvm][:user]
  creates "#{rvmsrcdir}/rvm-#{node[:rvm][:version]}"
  action :run
end

file "#{rvmsrcdir}/rvm-#{node[:rvm][:version]}/scripts/install" do
  mode "0755"
end

execute "rvm installer" do
  command "./scripts/install --prefix #{Shellwords.escape(File.dirname(rvmdir))} chef/ --path #{Shellwords.escape(rvmdir)}"
  user node[:rvm][:user]
  group node[:rvm][:user]
  cwd "#{rvmsrcdir}/rvm-#{node[:rvm][:version]}"
  action :run
end
