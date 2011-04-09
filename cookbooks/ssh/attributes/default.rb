default[:ssh][:type] = "dsa"
default[:ssh][:dir] = "/Users/#{node[:myself]}/.ssh"
default[:ssh][:private_key] = "#{node[:ssh][:dir]}/id_#{node[:ssh][:type]}"

