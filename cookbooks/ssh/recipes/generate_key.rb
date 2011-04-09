include_recipe "ssh::default"

execute "generate ssh key" do
  not_if "test -e #{node[:ssh][:private_key]}"
  command "ssh-keygen -q -t #{node[:ssh][:type]} -f #{node[:ssh][:private_key]} -N ''"
  user node[:myself]
end
