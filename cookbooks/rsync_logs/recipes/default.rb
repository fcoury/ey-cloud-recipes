#
# Cookbook Name:: rsync_logs
# Recipe:: default
#

run_for_app_env_role("workbeast", ["production"], %w(app app_master)) do |app_name, env, role|
  utility_instance_id = node[:utility_instances].first[:hostname]
  my_hostname = `curl http://169.254.169.254/latest/meta-data/public-hostname`

  cron "rsync_production_log_files" do
    user node[:owner_name]
    command "rsync -av /data/workbeast/shared/log/ rsync://#{utility_instance_id}/workbeast/#{my_hostname}"
  end
  cron "rsync_nginx_log_files" do
    user node[:owner_name]
    command "rsync -av /var/log/engineyard/nginx/ rsync://#{utility_instance_id}/workbeast/#{my_hostname}"
  end
end

run_for_app_env_role("workbeast", ["production"], ["util"]) do |app_name, env, role|
  directory "/home/#{node[:owner_name]}/#{app_name}_logs" do
    owner node[:owner_name]
    group node[:owner_name]
    mode "0777"
    action :create
    not_if "test -d /home/#{node[:owner_name]}/#{app_name}_logs"
  end

  template "/etc/rsyncd.conf" do
    source "rsyncd.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    variables({
      :app_name => app_name,
      :username => node[:owner_name]
    })
  end

  template "/etc/monit.d/rsync_damon.#{app_name}.monitrc" do
    source "rsync_daemon.monitrc.erb"
    owner node[:owner_name]
    group node[:owner_name]
    mode 0644
    variables({
      :app_name => app_name,
      :user => node[:owner_name],
      :environment => node[:environment][:framework_env]
    })
  end

end
