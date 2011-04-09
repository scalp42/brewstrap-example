include_recipe "github::known_hosts"
include_recipe "ssh::generate_key"

github_name="#{node[:myself]}@#{node[:hostname]}"

execute "upload ssh key to github" do
  command "curl --data-urlencode \"login=#{node[:github][:api][:login]}\" --data-urlencode \"token=#{node[:github][:api][:token]}\" --data-urlencode \"key=`cat #{node[:ssh][:private_key]}.pub`\" --data-urlencode \"name='#{github_name}'\" #{node[:github][:api][:add_url]}"
end

include_recipe "brewstrap::swap_in_private_git_repo"