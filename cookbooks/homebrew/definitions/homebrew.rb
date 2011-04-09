define :homebrew do
  execute "homebrew-install-#{params[:name]}" do
    command "brew install #{params[:name]}"
    user node[:myself]
  end
end
