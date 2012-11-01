#
# Cookbook Name:: aws_access
# Recipe:: default
#

run_for_app_env_role("workbeast", %(staging production), %w(solo util app app_master)) do |app_name, env, role|
  username = node[:users].first[:username]

  template "/data/#{app_name}/shared/config/ey-solo-#{app_name}.yml" do
    source "ey-solo.yml.erb"
    variables({
      :aws_secret_key => node[:aws_secret_key],
      :aws_secret_id => node[:aws_secret_id]
    })
    mode 0600
    owner username
    group username
  end
end
