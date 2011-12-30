define :launchctl, :action => :load do
  user_to_execute_as = params[:user]  ? params[:user] : ENV["USER"]
  action = params[:action].to_s
  raise "Unknown action #{action}" unless ["load", "unload"].include?(action)
  not_if_conditions = params[:not_if] || lambda { false }
  only_if_conditions = params[:only_if] || lambda { true }
  options = ""
  options << "-w" if File.exist?(params[:name])

  execute "launchctl #{action} #{options} #{params[:name]}" do
    not_if not_if_conditions
    only_if only_if_conditions
    command "launchctl #{action} #{options} #{params[:name]}"
    user user_to_execute_as
  end
end

