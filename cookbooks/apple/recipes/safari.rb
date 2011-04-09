plist "com.apple.Safari" do
  key "ShowStatusBar"
  value 1
  user node[:myself]
end

plist "com.apple.Safari" do
  key "WebKitMinimumFontSize"
  value 9
  user node[:myself]
end

plist "com.apple.Safari" do
  key "NewTabBehavior"
  value 1
  user node[:myself]
end

plist "com.apple.Safari" do
  key "NewWindowBehavior"
  value 1
  user node[:myself]
end

plist "com.apple.Safari" do
  key "OpenExternalLinksInExistingWindow"
  value 1
  user node[:myself]
end

plist "com.apple.Safari" do
  key "IncludeDevelopMenu"
  value 1
  user node[:myself]
end

plist "com.apple.Safari" do
  key "DownloadsClearingPolicy"
  value 2
  user node[:myself]
end

plist "com.apple.Safari" do
  key "HomePage"
  value ""
  user node[:myself]
end
