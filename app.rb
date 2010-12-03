require "sinatra"
require './init.rb'


get "/" do
  redirect "/scheduler"
end

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

get "/queue" do
  #load the queue
  $queue = load_queue
  #show the queue list
end

# Delete the selected queue item
delete "/queue" do

end

get "/calendar" do
  haml :calendar
end
