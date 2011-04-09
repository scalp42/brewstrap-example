application "MacVim.app" do
  source "http://cloud.github.com/downloads/b4winckler/macvim/MacVim-snapshot-57.tbz"
  source_dir "MacVim-snapshot-57"
end

file "/Users/#{node[:myself]}/.vimrc.local" do
  action :touch
end

cookbook_file "/usr/local/bin/mvim" do
  source "mvim"
  mode "0755"
  action :create_if_missing
end
