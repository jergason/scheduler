$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))
require "sinatra"
require "configuration"
require "queue"
require "pony"

# Edit configuration settings here
config = Scheduler::Configuration.new
config.notification_email_address = "change-me@exmaple.com"
config.email_sender = "scheduler@example.com"
config.queue_location = "queue.yaml"
config.calendar_html = "<foo>bahldlksjf</foo>"

$queue = Scheduler::Queue.new(config.queue_location)

# Routes
get "/" do
  redirect "/scheduler"
end

get "/scheduler" do
  haml :scheduler
end

post "/scheduler" do
  @name = params[:name]
  @email = params[:email]
  $queue << { :name => @name, :email => @email }
  $queue.save

  Pony.mail( :to => config.notification_email_address,
             :from => config.email_sender,
             :subject => "New Signup for Orbitrap",
             :body => <<-EOF
  New signup for the Orbitrap from #{params[:name]}, email: #{params[:email]}.
EOF
          )
  
  @success = true
  haml :scheduler
end

get "/queue" do
  haml :queue
end

# Delete the selected queue item
delete "/queue" do
  $queue.delete params[:id]
  $queue.save
  haml :queue
end

get "/calendar" do
  @calendar = config.calendar_html
  haml :calendar
end
