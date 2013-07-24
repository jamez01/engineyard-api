module EngineyardAPI
  # Account class
  class Account
	attr_reader :id, :name,:environments
    def initialize(account)
	  @id = account['id'] if account.has_key? 'id'
	  @name = account['name'] if account.has_key? 'name'
	  @environments = account.has_key?(environments) ? account['environments'] : [] 
	end
  end
end
