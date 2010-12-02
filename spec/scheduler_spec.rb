require 'spec_helper'

def app
  @app ||= Sinatra::Application
end

describe "Scheduler" do
  include Rack::Test::Methods

  describe "/scheduler" do
    it "should respond to /scheduler" do
      get "/scheduler"
      last_response.should be_ok
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
