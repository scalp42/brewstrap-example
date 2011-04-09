directory node[:ssh][:dir] do
  action :create
  owner node[:myself]
end

file "#{node[:ssh][:dir]}/known_hosts" do
  action :touch
  owner node[:myself]
end
