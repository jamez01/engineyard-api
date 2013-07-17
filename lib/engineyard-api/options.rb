module EngineyardAPI
  class Options
    @@options ||= Hash.new
    def self.inspect
      @@options
    end
    #~ def self.[](key)
      #~ @@options[key]
    #~ end
    #~ def self.[]=(key,value)
      #~ @@options[key]
    #~ end
  end
  def self.method_missing(*args)
    @@options.send(*args)
  end
end
