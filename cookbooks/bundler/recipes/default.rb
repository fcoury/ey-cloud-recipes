#
# Cookbook Name:: bundler
# Recipe:: default
#
# solve the bundler install problem on the utilty instance

run_for_app_env_role("workbeast", %w(production), %w(util app)) do |app_name, env, role|
  execute "bundler" do
    command "bundle install --without test development"
    cwd "/data/#{app_name}/current"
    action :run
  end
end
