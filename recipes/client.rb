#
# Cookbook Name:: dns
# Recipe:: client
#
# Copyright 2012, ModCloth, Inc!
#
# All rights reserved - Do Not Redistribute
#

include_recipe "dns::install"

directory "/root/keys" do
  mode "0755"
  action :create
end

template "/tmp/update_dns.sh" do
  source "update_dns.sh.erb"
  mode "0755"
  variables(
    :name => node.name,
    :domain => node.domain
  )
  not_if { node.domain =~ /local/}
end

template "/root/keys/ddns.key" do
  source "ddns.key.erb"
  mode "0600"
end

template "/root/keys/ddns.private" do
  source "ddns.private.erb"
  mode "0600"
end

execute "update-dns-record" do
  command "/tmp/update_dns.sh"
  only_if "ls /tmp/update_dns.sh"
end
