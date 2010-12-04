require "yaml"

module Scheduler
  class Queue
     include Enumerable

    def initialize(queue_location)
      @queue_location = queue_location
      @data = load
    end

    # Use an empty array if there is no config file or if it is empty
    def load
      queue =  open(@queue_location, "a+") { |f| YAML.load(f) || [] }
    end

    def save
      open(@queue_location, "w") { |f| YAML.dump(@data, f) }
      self
    end

    def <<(arg)
      @data << arg
      self
    end

    def delete(index)
      @data.delete_at(index.to_i)
    end

    def each
      @data.each do |i|
        yield i
      end
    end

    def count
      @data.count
    end
  end
end
