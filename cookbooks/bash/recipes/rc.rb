link "/var/root/.bash_profile" do
  to "#{node[:myhome]}/.bash_profile"
end

link "/var/root/.bash_profiles" do
  to "#{node[:myhome]}/.bash_profiles"
end
