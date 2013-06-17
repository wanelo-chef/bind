#
# Cookbook Name:: dns
# Recipe:: install
#
# Copyright 2012, ModCloth, Inc!
#
# All rights reserved - Do Not Redistribute
#

package node['dns']['bind9_package_name'] do
	action :install
end
