
module EngineyardAPI
  # Environment class stores all environment data, and crawls over other parts of the api to grab data for Instance and App classes.
  class Environment
    def initialize(id,environment = nil)
	  @environment = environment if environment
      @id = id
      @path = "/environments/#{id}"
      #EngineyardAPI::API = EngineyardAPI::API
      reload(environment)
    end

    def environment_id
      @environment['id']
    end

    def name
      @environment['name']
    end

    def instance_count
      @environment['instances_count']
    end

    def instances
      @instances
    end

    def instance_status
      @environment['instance_status']
    end
    def load_balancer_ip_address
      @environment['load_balancer_ip_address']
    end

    def account
      @environment['account']
    end

    def stack_name
      @environment['stack_name']
    end

    def ssh_username
      @environment['ssh_username']
    end

    def app_server_stack_name
      @environment['app_server_stack_name']
    end

    def framework_env
      @environment['framework_env']
    end

    def apps
      @applications
    end

    def deployment_configurations
      @environment['deployment_configurations']
    end

    def app_master
      @app_master
    end

    # This was mostly used for testing api. not used in script. keeping for future development reasons.
    def keys(k=nil)
      return  @environment.keys unless k
      return @environment[k]
    end

    # Create a new instance.  first param can take any arguments in hash that API would accept (i.e. :instance_size, :volume_size, etc)
    def add_instance(body,zone=nil)
      request = {:body => {:request => body}}
      request[:body][:request][:availability_zone] = zone if zone
      EngineyardAPI::API.post("#{@path}/add_instances", request)
    end

    # Checks to see how many add instance actions are working on environment. returns array.
    def add_status
      EngineyardAPI::API.get("#{@path}/add_instances")
    end

    # Remove instance. Provide role (:app, or :util), and :amazon_id if needed.
    def remove_instance(role, remove_instance=nil, callback=nil)
      ENV['INSTANCE'] = remove_instance.public_hostname if remove_instance
      system(callback) if callback
      request = {:body => { :request => {:role => role } } }
      request[:body][:request][:provisioned_id] = remove_instance.amazon_id if remove_instance
      EngineyardAPI::API.post("#{@path}/remove_instances",request)
    end

    # Same as add_status, except checks for instances being removed. retruns array.
    def remove_status
      EngineyardAPI::API.get("#{@path}/remove_instances")
    end

    # Used for development. same as keys method, but does not return a list of keys if no params.
    def [](key)
      @enviornment[key]
    end

    # Checks if environment is busy. returns true and hash of actions if instances are being added, instances are being removed, or if deploy is ongoing.
    def busy?
      return true, {:add_status => add_status["requests"] , :remove_status => remove_status["requests"] } if add_status["requests"].count > 0 or remove_status["requests"].count > 0
      return false
    end

    # Checks if environment is deploying (works for standard deploy only (i.e. via dashboard or ey_cli utillity)
    def deploying?
      return true if apps.select {|app| app.last_deploy['finished_at'] == nil }.count > 0
      return false
    end

    # Like pressing 'apply' on dashboard
    def rebuild
      EngineyardAPI::API.put("#{@path}/update_instances",{:body => ""})
    end

    ## Call environment information from API. Information is cached in class until reload is called again. Prevents calling API when not needed.
    def reload(e=nil)
      @environment = EngineyardAPI::API.get(@path)['environment'] unless e
      @instances = Array.new
      @applications = Array.new
      # Populate instances
      @environment['instances'].each {|instance|
        @instances << EngineyardAPI::Instance.new(instance)
      }
      # Populate Apps
      @environment['apps'].each {|app|
        @applications << EngineyardAPI::App.new(app)
      }
      @app_master=App.new(@environment['app_master'])
      @applications.each { |app| app.last_deploy=EngineyardAPI::API.get("/apps/#{app.app_id}/environments/#{environment_id}/deployments/last")['deployment'] }
      return true
    end
  end
end
