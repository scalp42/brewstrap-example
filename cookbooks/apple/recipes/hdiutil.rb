cookbook_file "/tmp/hdiutil.exp" do
  source "hdiutil.exp"
  mode "0755"
  owner "root"
  group "wheel"
end
