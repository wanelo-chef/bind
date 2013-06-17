case node['platform']
when "smartos"
  default[:dns][:bind9_package_name] = "bind"
  default[:dns][:bin] = "/opt/local/bin"
else
  default[:dns][:bind9_package_name] = "bind9"
  default[:dns][:bin] = "/usr/bin"
end

default[:dns][:master]                = "192.168.0.1"
default[:dns][:primary_slave]         = "192.168.0.2"
default[:dns][:secondary_slave]       = "192.168.0.3"
default[:dns][:keyfile]               = "/root/keys/ddns.private"