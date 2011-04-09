define :font do
  directory "#{node[:mylibrary]}/Fonts" do
    action :create
    owner node[:myself]
  end
  
  remote_file "#{node[:mylibrary]}/Fonts/#{params[:name]}" do
    not_if "test -e '#{node[:mylibrary]}/Fonts/#{params[:name]}'"
    source params[:source]
    mode "0644"
    owner node[:myself]
  end
end

