cookbook_file "/etc/sudoers" do
  source "sudoers"
  mode "0440"
  owner "root"
  group "wheel"
end
