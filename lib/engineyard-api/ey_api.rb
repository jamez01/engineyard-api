
module EngineyardAPI
  # Actually communicates with API.
  class EyAPI # :nodoc:
    include HTTParty
    base_uri 'https://cloud.engineyard.com:443/api/v2/'
    format :json
    headers 'Accept' => 'application/json'
    headers 'Content-Type' => 'application/json'

    def initialize(key = $options[:key]) # :nodoc:
      @api_key = key

    end

    def get(path) # :nodoc:
      self.class.get(path, :headers => { 'X-EY-Cloud-Token' => @api_key })
    end

    def post(path,data) # :nodoc:
      self.class.post(path,data.merge(:headers=> { 'X-EY-Cloud-Token' => @api_key}))
    end
    def put(path,data={}) # :nodoc:
      self.class.put(path,data.merge(:headers => { 'X-EY-Cloud-Token' => @api_key}))
    end
  end
end
