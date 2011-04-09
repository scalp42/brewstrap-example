template "/Users/#{node[:user][:username]}/.gitconfig" do
  source "dot-gitconfig.erb"
  owner node[:user][:username]
end
