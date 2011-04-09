template "/usr/local/bin/rebrewstrap" do
  source "rebrewstrap.sh.erb"
  owner "root"
  group "wheel"
  mode "0755"
end
