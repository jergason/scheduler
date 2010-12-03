$LOAD_PATH.unshift(File.dirname(__FILE__))
require "sinatra"
require "queue"
require "pony"
require "config/settings"

$queue = Scheduler::Queue.new(settings.queue_location)

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

  Pony.mail( :to => settings.notification_email_address,
             :from => settings.email_sender,
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
  @calendar = settings.calendar_html
  haml :calendar
end
