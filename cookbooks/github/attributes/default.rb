default[:github][:username] = ENV["GITHUB_LOGIN"]

default[:github][:api][:add_url] = "http://github.com/api/v2/json/user/key/add"
default[:github][:api][:token] = ENV["GITHUB_TOKEN"]
