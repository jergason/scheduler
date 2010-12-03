$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))
require "configuration"


# Edit configuration settings here
config = Scheduler::Configuration.new
config.email = "jergason@byu.net"
config.yaml_location = "queue.yaml"
config.calendar_html = "<foo>bahldlksjf</foo>"

