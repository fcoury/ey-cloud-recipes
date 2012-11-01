class Chef
  class Recipe
    def run_for_app(app, &block)
      node[:applications].map{|k,v| [k,v] }.sort_by {|a,b| a }.each do |name, app_data|
        if name == app
          block.call(name, app_data)
        end
      end
    end

    def run_for_app_env_role(app, env, roles, &block)
      node[:applications].map{|k,v| [k,v] }.sort_by {|a,b| a }.each do |name, app_data|
        if name == app and roles.include?(node[:instance_role]) and env.include?(node[:environment][:name])
          block.call(name, node[:environment][:name], node[:instance_role])
        end
      end
    end
  end
end
