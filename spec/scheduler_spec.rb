require 'spec_helper'

def app
  @app ||= Sinatra::Application
end

describe "Scheduler" do
  include Rack::Test::Methods

  it "should have the correct title" do
    get '/scheduler'
    last_response.should =~ /<title>Mass Spec Scheduler<\/title>/
  end

  describe "/scheduler" do
    it "should respond to /scheduler" do
      get "/scheduler"
      last_response.should be_ok
    end

    it "should render the correct template" do
      get "/scheduler"
      last_response.body.should =~ /Sign up to use the mass spec/
    end
  end

  describe "/" do
    it "should be successful" do
      get "/"
      last_response.should be_ok
    end

    it "says hello" do
      get '/'
      last_response.body.should == "Hello!"
    end
  end
end
