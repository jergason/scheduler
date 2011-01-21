$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include? File.dirname(__FILE__)
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib")) unless $LOAD_PATH.include? File.join(File.dirname(__FILE__), "lib")

require "sinatra"
require "rack-flash"
require "settings"
require "scheduler"

enable :sessions
use Rack::Flash
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
                                          :sample_description => params[:submission][:sample_description],
                                          :date => params[:submission][:date],
                                          :time => params[:submission][:time])
  if @submission.save
    @submission.mail(settings.email_recipient, settings.email_sender)
    flash[:success] = "Successfully signed up for the mass spec. Keep an eye on your email for more information."
  else
    flash[:error] = "There was an error creating your signup. Whoops!"
  end
  redirect '/scheduler', 303
end

get "/submissions" do
  @submissions = Scheduler::Submission.all(:display => true)
  haml :submissions
end

get "/submissions/:id" do
  @submission = Scheduler::Submission.get(params[:id])
  haml :submission
end

delete "/submissions" do
  @submission = Scheduler::Submission.get(params[:id])
  @submission.update(:display => false)
  flash[:success] = "Deleted submission by #{@submission.name}."
  redirect '/submissions', 303
end

get "/calendar" do
  @calendar = settings.calendar_html
  haml :calendar
end

