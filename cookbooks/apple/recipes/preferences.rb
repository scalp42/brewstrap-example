execute "restart-dock" do
  command "killall -HUP Dock"
  action :nothing
end

if node[:apple][:dock] && node[:apple][:dock][:preferences]
  node[:apple][:dock][:preferences].each do |preference_key, preference_value|
    plist "#{node[:apple][:domain]}.dock" do
      key preference_key
      value preference_value
      user node[:myself]
      notifies :run, "restart-dock"
    end
  end
end

execute "restart-finder" do
  command "killall -HUP Finder"
  action :nothing
end

if node[:apple][:finder] && node[:apple][:finder][:preferences]
  node[:apple][:finder][:preferences].each do |preference_key, preference_value|
    plist "#{node[:apple][:domain]}.finder" do
      key preference_key
      value preference_value
      user node[:myself]
      notifies :run, "restart-finder"
    end
  end
end

if node[:apple][:terminal] && node[:apple][:terminal][:preferences]
  node[:apple][:terminal][:preferences].each do |preference_key, preference_value|
    plist "#{node[:apple][:domain]}.terminal" do
      key preference_key
      value preference_value
      user node[:myself]
    end
  end
end
