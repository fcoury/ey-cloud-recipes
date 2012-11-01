#
# Cookbook Name:: wkhtml2pdf
# Recipe:: default
#

run_for_app_env_role("workbeast", %w(staging production), %w(solo util)) do |app_name, env, role|
  username = node[:owner_name]

  remote_file "/home/#{username}/wkhtmltopdf-0.9.5-static-i386.tar.bz2" do
    source "wkhtmltopdf-0.9.5-static-i386.tar.bz2"
    mode 0755
    owner username
    group username
    not_if "test -f /usr/bin/wkhtmltopdf"
  end

  execute "unpack wkhtmltopdf" do
    creates "/usr/bin/wkhtmltopdf-i386"
    cwd "/usr/bin"
    command "tar -xjf /home/#{username}/wkhtmltopdf-0.9.5-static-i386.tar.bz2"
    action :run
    not_if "test -f /usr/bin/wkhtmltopdf"
  end

  execute "install wkhtmltopdf" do
    creates "/usr/bin/wkhtmltopdf"
    cwd "/usr/bin"
    command "mv wkhtmltopdf-i386 wkhtmltopdf"
    not_if "test -f /usr/bin/wkhtmltopdf"
  end

end
