application "Flash Player" do
  not_if "test -e '/Library/Internet Plug-Ins/Flash Player.plugin'"
  source "http://fpdownload.macromedia.com/get/flashplayer/current/install_flash_player_osx_ub.dmg"
end
