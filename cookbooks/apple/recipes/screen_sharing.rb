execute "copy screen sharing to applications" do
  not_if "test -e '#{node[:applications][:dir]}/Screen Sharing.app'"
  command "cp -rp '/System/Library/CoreServices/Screen Sharing.app' #{node[:applications][:dir]}"
end
