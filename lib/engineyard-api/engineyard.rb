module EngineyardAPI
  # Allow for Engineyard.new(account)
  def EngineyardAPI.new(*args)
	#~ puts args
	Engineyard.new(*args)
  end
  
  class Engineyard
	attr_accessor :accounts
    def initialize(options)
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
		  puts e['account']['id']
		  account_by_id(e['account']['id']).environments << Environment.new(e['id'],e)  
		}
      return true
    end
    def account_by_id(id)
	  ac = @accounts.select { |a| a.id == id }
	  raise "No such account" unless ac.count == 1
	  return ac[0]
    end
    def account_by_name(name)
	  ac = @accounts.select { |a| a.name == name }
	  raise "No such account" unless ac.count == 1
	  return ac[0]
    end
  end
end
