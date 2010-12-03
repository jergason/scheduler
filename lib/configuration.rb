module Scheduler
  class Configuration
    def initialize(data={})
      @data = data
      update!(data)
    end

    def update!(data)
      data.each do |key, value|
        self[key] = value
      end
    end

    def [](key)
      @data[key.to_sym]
    end

    def []=(key, value)
      if value.class == Hash
        @data[key.to_sym] = Configuration.new(value)
      else
        @data[key.to_sym] = value
      end
    end

    # Allow dot access to properties
    def method_missing(name, *args)
      if name.to_s =~ /(.+)=$/
        self[$1.to_sym] = args.first
      else
        self[name]
      end
    end
  end
end
