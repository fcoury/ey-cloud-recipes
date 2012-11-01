#
# Cookbook Name:: nginx_no_www
# Recipe:: default
#
# Install rewrites file
# Normally used to permanently redirect www to URL with no host name

run_for_app_env_role("workbeast", %w(production), %w(app app_master)) do |app_name, env, role|
  username = node[:users].first[:username]
  remote_file "/data/nginx/servers/#{app_name}.rewrites" do
    source "rewrites.conf"
    owner username
    group username
    mode "0644"
  end
end
