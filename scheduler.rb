require 'sinatra'

get "/scheduler" do
  haml :scheduler
end

post "/scheduler" do

end

get "/" do
  "Hello!"
end
