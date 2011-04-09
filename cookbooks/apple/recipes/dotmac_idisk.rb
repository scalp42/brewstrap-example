have_idisk_sync_set = 0
have_phd_sync_set = 1
cleaned_up_old_idisks = 0
mirror_enabled = 0

if node[:apple][:dotmac][:idisk][:enable_mirroring] == true 
  have_idisk_sync_set = 1
  have_phd_sync_set = 0
  cleaned_up_old_idisks = 1
  mirror_enabled = 1
end

plist "#{node[:apple][:domain]}.FileSyncAgent" do
  key "haveiDiskSyncSet"
  value have_idisk_sync_set
  user node[:myself]
end
  
plist "#{node[:apple][:domain]}.FileSyncAgent" do
  key "havePHDSyncSet"
  value have_phd_sync_set
  user node[:myself]
end

plist "#{node[:apple][:domain]}.FileSyncAgent" do
  key "CleanedUpOldIDisks"
  value cleaned_up_old_idisks
  user node[:myself]
end

plist "#{node[:apple][:domain]}.idisk" do
  key "#{node[:apple][:dotmac][:username]}_MirrorEnabled"
  value mirror_enabled
  current_host true
  user node[:myself]
end

# launchctl "/System/Library/LaunchAgents/#{node[:apple][:domain]}.FileSyncAgent.plist" do
#   action :load
#   user node[:myself]
# end
#   
# launchctl "/System/Library/LaunchAgents/#{node[:apple][:domain]}.syncservices.SyncServer.plist" do
#   action :load
#   user node[:myself]
# end
# 
