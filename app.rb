$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include? File.dirname(__FILE__)
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib")) unless $LOAD_PATH.include? File.join(File.dirname(__FILE__), "lib")

require "sinatra"
require "settings"
require "scheduler"

helpers Scheduler::Helpers

# Routes
get "/" do
  redirect "/scheduler"
end

get "/scheduler" do
  haml :scheduler
end

post "/scheduler" do
  @submission = Scheduler::Submission.new(:name => params[:submission][:name],
                                          :principal_investigator => params[:submission][:pi],
                                          :department => params[:submission][:department],
                                          :email => params[:submission][:email],
                                          :phone_number => params[:submission][:phone],
                                          :sample_type => params[:submission][:sample_type],
                                          :number_of_samples => params[:submission][:number_of_samples],
                                          :sample_origin => params[:submission][:sample_origin],
                                          :sample_description => params[:submission][:sample_description])
  @submission.save
  @submission.mail(settings.email_recipient, settings.email_sender)
  redirect '/scheduler', 303
end

get "/queue" do
  @submissions = Scheduler::Submission.all(:display => true)
  haml :queue
end

delete "/queue" do
  @submission = Scheduler::Submission.get(params[:id])
  @submission.update(:display => false)
  redirect '/queue', 303
end

get "/calendar" do
  @calendar = settings.calendar_html
  haml :calendar
end

