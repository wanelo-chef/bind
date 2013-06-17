#
# Cookbook Name:: dns
# Recipe:: slave
#
# Copyright 2012, ModCloth, Inc!
#
# All rights reserved - Do Not Redistribute
#

include_recipe "dns::install"

directory "/var/named" do
  owner "named"
  group "named"
	mode "0777"
end

service "dns/server" do
  action :enable
end

execute "reload-config" do
  command "/opt/local/sbin/rndc reload"
  action :nothing
end

template "/opt/local/etc/named.conf" do
  source "named.conf-slave.erb"
  notifies :restart, "service[dns/server]"
end

template "/opt/local/etc/rndc.key" do
  source "rndc.key.erb"
  mode "0600"
  notifies :restart, "service[dns/server]"
end
