#
# Cookbook Name:: nginx_basic_auth
# Recipe:: default
#

run_for_app_env_role("workbeast", %w(staging), %w(solo)) do |app_name, env, role|
  ey_cloud_report "nginx_basic_auth" do
    message "configuring nginx basic authentication"
  end

  username = node[:users].first[:username]
  template "/data/nginx/servers/#{app_name}/custom.locations.conf" do
    source "custom.locations.conf.erb"
    mode "0644"
    owner username
    group username
    variables({ :app_name => app_name })
  end

  execute "create htpasswd" do
    command "htpasswd -cbd /data/nginx/servers/#{app_name}/htpasswd test WorkBeast"
    creates "/data/nginx/servers/#{app_name}/htpasswd"
    action :run
  end
end
