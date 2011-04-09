valid_extensions = ["qtz", "saver", "slideSaver"]
module_name = node[:apple][:screensaver][:selected]

valid_extensions.each do |extension|
  module_path = "#{node[:apple][:screensaver][:path]}/#{module_name}.#{extension}"
  if File.exist?(module_path)
    plist "#{node[:apple][:domain]}.screensaver" do
      key "moduleName"
      value module_name
      current_host true
      user node[:myself]
    end
    plist "#{node[:apple][:domain]}.screensaver" do
      key "modulePath"
      value module_path
      current_host true
    end 
  end
end

