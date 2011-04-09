default[:myself] = ENV["SUDO_USER"] || `id -u -n 501`.strip
default[:myhome] = "/Users/#{node[:myself]}"
default[:mylibrary] = "#{node[:myhome]}/Library"

default[:apple][:domain] = "com.apple"

default[:apple][:screensaver][:path] = "/System/Library/Screen\ Savers"
default[:apple][:menubar][:path] = "/System/Library/CoreServices/Menu\ Extras"

default[:apple][:utilities][:keychain][:path] = "/Applications/Utilities/Keychain Access.app" 
default[:applications][:dir] = "/Applications"