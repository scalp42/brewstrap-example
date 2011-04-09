define :plist do
  value = params[:value]
  value_option = ""
  if value.is_a?(Array)
    value_option = "-array"
    value = value.map do |v|
      v.inspect
    end.join(" \\\n")
  elsif value.is_a?(Hash)
    value_option = "-dict"
    value = value.map do |k, v|
      "#{k.inspect} #{v.inspect}"
    end.join(" ")
  elsif value.is_a?(TrueClass) || value.is_a?(FalseClass)
    value_option = "-boolean"
  elsif value.is_a?(String)
    value = value.inspect
  end

  host_option = (params[:current_host] == true) ? "-currentHost" : ""
  user_to_execute_as = params[:user] ? params[:user] : ENV["USER"]

  raise "No key found!" unless params[:key]
  raise "No domain found!" unless params[:name]
  execute "write to plist file" do
    command "defaults #{host_option} write #{params[:name]} '#{params[:key]}' #{value_option} #{value}"
    user user_to_execute_as
  end
end

