module EngineyardAPI
  # Users (and API keys) can have access to multiple accounts.
  class Account
  # Returns account id as an Integer
	attr_reader :id
  # Returns Account name as a String 
  attr_reader :name
  # Returns a list of environments in an Array
  attr_reader :environments
  
  
  def initialize(account) # :nodoc:
	  @id = account['id'] if account.has_key? 'id'
	  @name = account['name'] if account.has_key? 'name'
	  @environments = account.has_key?(environments) ? account['environments'] : [] 
	end
  end
end
