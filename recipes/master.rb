#
# Cookbook Name:: dns
# Recipe:: master
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

execute "sync-master" do
  command "rndc sync"
  action :nothing
end

execute "update-zone" do
  command "nsupdate -v -k /root/keys/ddns.private < /tmp/zone.domain.com-static"
  action :nothing
end

template "/opt/local/etc/named.conf" do
  source "named.conf-master.erb"
  notifies :run, resources(:execute => "sync-master")
  notifies :restart, "service[dns/server]"
end

template "/opt/local/etc/keys.conf" do
  source "keys.conf.erb"
  mode "0600"
  notifies :run, resources(:execute => "sync-master")
  notifies :restart, "service[dns/server]"
end

template "/opt/local/etc/rndc.key" do
  source "rndc.key.erb"
  mode "0600"
  notifies :run, resources(:execute => "sync-master")
  notifies :restart, "service[dns/server]"
end

template "/tmp/zone.domain.com-static" do
  source "zone.domain.com-static.erb"
  notifies :run, resources(:execute => "sync-master")
  notifies :run, resources(:execute => "update-zone")
end

template "/var/named/localhost.zone" do
  source "localhost.zone.erb"
  mode "0644"
  not_if "ls /var/named/localhost.zone"
end

template "/var/named/zone.domain.com.zone" do
  source "zone.domain.com.zone.erb"
  mode "0644"
  not_if "ls /var/named/zone.domain.com.zone"
end
