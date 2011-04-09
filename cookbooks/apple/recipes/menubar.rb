array_of_menu_items = []
(node[:apple][:menubar][:items] || []).each do |item|
  if item.downcase == "keychain" 
    array_of_menu_items << "#{node[:apple][:utilities][:keychain][:path]}/Contents/Resources/Keychain.menu"
  else
    menu_path = "#{node[:apple][:menubar][:path]}/#{item}.menu"
    if File.exist?(menu_path)
      array_of_menu_items << menu_path
    else
      raise "Unable to find menu item '#{menu_path}'"
    end
  end
end

plist "#{node[:apple][:domain]}.systemuiserver", "menuExtras" do
  user node[:myself]
  key "menuExtras"
  value array_of_menu_items
end
