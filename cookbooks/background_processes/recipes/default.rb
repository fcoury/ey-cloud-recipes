#
# Cookbook Name:: background_processes
# Recipe:: default
#

run_for_app_env_role("workbeast", %w(staging production), %w(solo util)) do |app_name, env, role|
  execute "monit" do
    command "monit -g workbeast restart all"
    action :run
  end

  execute "whenever" do
    command "bundle exec whenever --update-crontab"
    user node[:owner_name]
    cwd "/data/#{app_name}/current"
    action :run
  end
end
