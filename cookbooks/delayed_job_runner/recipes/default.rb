#
# Cookbook Name:: delayed_job_runner
# Recipe:: default
#

run_for_app_env_role("workbeast", %w(staging production), %w(solo util)) do |app_name, env, role|

  template "/etc/monit.d/delayed_job_runner.#{app_name}.monitrc" do
    source "delayed_job_runner.monitrc.erb"
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
