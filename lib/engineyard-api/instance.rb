module EngineyardAPI
  # Store information on instances
  class Instance
    def initialize(instance) # :nodoc:
      @instance = instance
      @logs = EngineyardAPI::API.get "/instances/#{@instance['id']}/logs"
      @alerts = EngineyardAPI::API.get "/instances/#{@instance['id']}/alerts"
    end
    
    # Return internal ID
    def instance_id
      @instance['id']
    end
    
    # Return instance status (i.e. :running, :error, etc)
    def status
      @instance['status']
    end
    
    # Return instance role (i.e., app, utility, db, db_master, app_master
    def role
      @instance['role']
    end
    
    # Retruns instance nam
    def name
      @instance['name']
    end
    
    # Return amazon ID
    def amazon_id
      @instance['amazon_id']
    end
    
    # Return instance public hostname
    def public_hostname
      @instance['public_hostname']
    end
    
    # Retruns instance zone
    def zone
      @instance['availability_zone']
    end
    
    # Returns list of log entries as array
    def logs
      return @logs['logs']
    end
    def [](key) # :nodoc:
      @instance['key']
    end
    
    # Returns list of alerts as array
    def alerts
      return @alerts['alerts']
    end

  end
end
