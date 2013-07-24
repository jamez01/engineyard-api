
module EngineyardAPI
  # Class to store application information
  class App

    def initialize(app) # :nodoc:
      @app=app
    end

    # Returns application id in form of an integer
    def app_id
      @app['id']
    end

    # Return account name as string
    def name 
      @app['name']
    end
    
    # Return repository associated to application
    def repository
      @app['repository_uri']
    end

    # Returns type of application
    def app_type 
      @app['app_type_id']
    end
    
    # Return account id as integer
    def account_id 
      @app['account']['id']
    end
    
    # Return account nam eas string
    def account_name 
      @app['account']['name']
    end

    def [](key) # :nodoc:
      @app['key']
    end

    def zone # :nodoc:
      @app['availability_zone']
    end

    def last_deploy=(deployment) # :nodoc:
      @last_deploy=deployment
    end

    def last_deploy # :nodoc:
      @last_deploy
    end
  end
end
