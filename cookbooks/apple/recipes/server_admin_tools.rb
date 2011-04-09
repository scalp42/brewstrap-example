application "ServerAdminTools10.6.dmg" do
  not_if "test -e '/Applications/Server/Server Admin.app'"
  source "http://support.apple.com/downloads/DL914/en_US/ServerAdminTools10.6.dmg"
end