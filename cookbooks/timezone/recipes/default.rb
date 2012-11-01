#
# Cookbook Name:: timezone
# Recipe:: default
#

run_for_app("workbeast") do |app_name, data|
  link "/etc/localtime" do
    filename = "/usr/share/zoneinfo/UCT"
    to filename
    only_if { File.exists? filename }
  end
end

