$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))

require 'sinatra'

Submission = Struct.new(:name, :email)

get "/scheduler" do
  haml :scheduler
end

post "/scheduler" do
  @name = params[:name]
  @email = params[:email]
  #save it to the yaml file
  
  # render the form and show a success message
  @success = true
  haml :scheduler
end

get "/" do
  "Hello!"
end

get "/queue" do
  #load the queue
  $queue = load_queue
  #show the queue list
end
