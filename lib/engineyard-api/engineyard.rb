
module EngineyardAPI
  # Create new Engineyard object bassed off supplied options
  # Example:
  #  @ey = Engineyard.new(:key => "myapikey")
  def EngineyardAPI.new(*args)
	Engineyard.new(*args)
  end
  
  # Main class returned by EngineyardAPI.new(:key => "key")
  class Engineyard
	attr_accessor :accounts


    def initialize(options)  #:nodoc
	  @accounts = []
      raise ArgumentError, "API key not specified. #{self.class}.new(:key => '<api_key>')" unless options.has_key? :key
      @options=options
#      @path = "/environments/#{id}"
      @api = EngineyardAPI::EyAPI.new(@options[:key])
      EngineyardAPI.const_set("API", @api)
      reload
    end
	
    ## Call environment information from API. Information is cached in class until reload is called again. Prevents calling API when not needed.
    def reload
	  account_list=@api.get("/accounts")['accounts']
      environment_list=@api.get("/environments")['environments']
      account_list.each {|a| @accounts << Account.new(a) }
		environment_list.each {|e|
		  account_by_id(e['account']['id']).environments << Environment.new(e['id'],e)  
		}
      return true
    end
    
    # Returns array of environments
    def environments
      return @accounts.map { |account| account.environments }.flatten
    end 
    
    
    # Find an environment based on name.  Returns EngineyardAPI::Environment 
    def environment_by_name(name)
      return environments.select {|e| e.name == name }.first
    end

    # Find an environment based on name.  Returns EngineyardAPI::Environment
    def environment_by_id(id)
      return environments.select {|e| e.environment_id == id }.first
    end
    
    # Find an account based on name.  Returns EngineyardAPI::Account
    def account_by_id(id)
	  ac = @accounts.select { |a| a.id == id }
	  raise "No such account" unless ac.count == 1
	  return ac[0]
    end

    # Locate an account by name.  Returns EngineyardAPI::Account
    def account_by_name(name)
	  ac = @accounts.select { |a| a.name == name }
	  raise "No such account" unless ac.count == 1
	  return ac[0]
    end
  end
end
