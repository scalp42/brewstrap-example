define :launchctl, :action => :load do
  user_to_execute_as = params[:user]  ? params[:user] : ENV["USER"]
  action = params[:action].to_s
  raise "Unknown action #{action}" unless ["load", "unload"].include?(action)
  
  options = ""
  options << "-w" if File.exist?(params[:name])
  
  execute "launchctl #{action} #{options} #{params[:name]}" do
    command "launchctl #{action} #{options} #{params[:name]}"
    user user_to_execute_as
  end
end

