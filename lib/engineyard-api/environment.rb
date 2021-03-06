
module EngineyardAPI
  # Environment class stores all environment data, and crawls over other parts of the api to grab data for Instance and App classes.
  class Environment
    def initialize(id,environment = nil) # :nodoc:
	  @environment = environment if environment
      @id = id
      @path = "/environments/#{id}"
      #EngineyardAPI::API = EngineyardAPI::API
      reload(environment)
    end
    
    # Returns integer containing environment ID
    def environment_id
      @environment['id']
    end

    # Returns String containing th eenvironment name
    def name
      @environment['name']
    end

    # Returns number of instances in environment
    def instance_count
      @environment['instances_count']
    end

    # Returns array full of EngineyardAPI::Instnaces
    def instances
      @instances
    end

    # Returns current status
    def instance_status
      @environment['instance_status']
    end
    
    # Return load balancer IP address, if any.
    def load_balancer_ip_address
      @environment['load_balancer_ip_address']
    end

    def account # :nodoc:
      @environment['account']
    end

    # Name of current stack associated with environment
    def stack_name
      @environment['stack_name']
    end

    # Default user used for deployments (usually 'deploy')
    def ssh_username
      @environment['ssh_username']
    end
  
    # Returns current stack name
    def app_server_stack_name
      @environment['app_server_stack_name']
    end

    # Returns framework environment (i.e. "production", or "staging")
    def framework_env
      @environment['framework_env']
    end

    # Returns array of EngineyardAPI::APP's 
    def apps
      @applications
    end


    def deployment_configurations
      @environment['deployment_configurations']
    end

    # Return EngineyardAPI::Instance of current app_master
    def app_master
      @app_master
    end

    # This was mostly used for testing api. not used in script. keeping for future development reasons.
    def keys(k=nil) # :nodoc:
      return  @environment.keys unless k
      return @environment[k]
    end

    # Create a new instance.  first param can take any arguments in hash that API would accept (i.e. :instance_size, :volume_size, etc)
    def add_instance(body)
      request = {:body => {:request => body}}
      EngineyardAPI::API.post("#{@path}/add_instances", request)
    end

    # Checks to see how many add instance actions are working on environment. returns array.
    def add_status
      EngineyardAPI::API.get("#{@path}/add_instances")
    end

    # Remove instance. Provide role (:app, or :util), and :amazon_id if needed.
    def remove_instance(remove_instance)
      request = {:body => { :request => {:role => role } } } if [:app,:util].include? remove_instance
      request = {:body => { :request => { :provisioned_id  => remove_instance.amazon_id } }} unless [:app,:util].include? remove_instance
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
