define :application do
  include_recipe "apple::hdiutil"
  source_type = params[:source_type]
  if source_type.nil?
    case params[:source]
    when /\.zip/
      source_type = :zip
    when /\.dmg/
      source_type = :dmg
    when /\.tbz/
      source_type = :tbz
    when /\.pkg/
      source_type = :pkg
    end
  end
  
  app_name = params[:name]
  app_name_safe = params[:name].gsub(/\s/, "_").gsub(/\//, "_")
  package_dir = "/tmp/chef_package-#{app_name_safe}"
  not_if_conditions = params[:not_if] || "false"
  already_installed = "#{not_if_conditions} || test -d '#{node[:applications][:dir]}/#{app_name}' || test -d '#{node[:mylibrary]}/PreferencePanes/#{app_name}'"

  remote_file package_dir do
    not_if "#{already_installed} || test -e #{package_dir}"
    source params[:source]
    mode "0644"
  end
  if source_type.is_a?(Array)
    inner_source_type = source_type[1]
    source_type = source_type[0]
  end

  case source_type
  when :zip
    if params[:use_installer]
      directory "#{package_dir}_unpacked" do
        not_if already_installed
        action :create
      end
      execute "unzip #{package_dir}" do
        not_if already_installed
        command "unzip -o #{package_dir} -d #{package_dir}_unpacked"
        cwd "/tmp"
      end
      execute "install #{package_dir}" do
        not_if already_installed
        command "installer -verbose -pkg *.mpkg -target /"
        cwd "#{package_dir}_unpacked"
      end
    else
      execute "unzip #{package_dir}" do
        not_if already_installed
        command "unzip -o #{package_dir} -d #{node[:applications][:dir]}/"
        cwd "/tmp"
      end
    end
  when :tbz
    directory "#{package_dir}_unpacked" do
      not_if already_installed
      action :create
    end
    execute "unpack #{package_dir}" do
      not_if already_installed
      command "tar xvf #{package_dir}"
      cwd "/tmp"
    end
    script "install #{app_name}" do
      not_if already_installed 

      interpreter "bash"
      cwd "/tmp/#{params[:source_dir]}"
      code <<-EOS
        if [ -e *.app ]; then
          cp -r "#{app_name}" #{node[:applications][:dir]}/
        fi
        if [ -e *.prefPane ]; then
          cp -r "#{app_name}" #{node[:mylibrary]}/PreferencePanes/
        fi
      EOS
    end
    directory "/tmp/#{params[:source_dir]}" do
      only_if "test -d /tmp/#{params[:source_dir]}" 
      recursive true
      action :delete
    end
  when :pkg
    execute "install #{package_dir}" do
      not_if already_installed
      command "installer -verbose -pkg #{package_dir} -target /"
      cwd "/tmp"
    end
  when :dmg
    mount_point = "/Volumes/chef_package-#{app_name_safe}"
    already_mounted = "test -e #{mount_point}/*.app || test -e #{mount_point}/*.mpkg || test -e #{mount_point}/*.prefPane"
    
    directory mount_point do
      not_if already_installed
      
      action :create
    end
    execute "mount #{package_dir}" do
      not_if "#{already_installed} || #{already_mounted}" 
      
      command "/tmp/hdiutil.exp  #{package_dir} #{mount_point}"
    end
    unless params[:noop]
      script "install #{app_name}" do
        not_if already_installed 

        interpreter "bash"
        cwd mount_point
        code <<-EOS
          if [ -e *.app ]; then
            cp -r "#{app_name}" #{node[:applications][:dir]}/
          fi
          if [ -e *.prefPane ]; then
            cp -r "#{app_name}" #{node[:mylibrary]}/PreferencePanes/
          fi
        EOS
      end

      execute "detach #{mount_point}" do
        only_if already_mounted
      
        command "hdiutil detach -Force #{mount_point}"
      end
      directory mount_point do
        only_if "test -d #{mount_point}" 
      
        action :delete
      end
    end
  else
    raise "I don't know how to install application #{app_name}, source type is #{source_type}"
  end
end

