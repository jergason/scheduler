$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))
require "sinatra"
require "scheduler"
require "config/settings"

$queue = Scheduler::Queue.new(settings.queue_location)

helpers Scheduler::Helpers

# Routes
get "/" do
  redirect "/scheduler"
end

get "/scheduler" do
  haml :scheduler
end

post "/scheduler" do
  $queue << { :name => params[:name], :email => params[:email] }
  $queue.save

  Scheduler::Email.mail(params, settings.email_recipient, settings.email_sender)
  @success = true
  haml :scheduler
end

get "/queue" do
  haml :queue
end

delete "/queue" do
  $queue.delete params[:id]
  $queue.save
  haml :queue
end

get "/calendar" do
  @calendar = settings.calendar_html
  haml :calendar
end

