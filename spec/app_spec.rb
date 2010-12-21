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

    it "should show a form" do
      get "/scheduler"
      last_response.body.should =~ /<form/
    end

    context "when submitting a form" do
      let(:params) do  
        { 
          :name => "John Smith",
          :principal_investigator => "John Smith",
          :department => "Chemistry",
          :email => "email@example.com",
          :phone_number => "111-111-1111",
          :sample_type => "lipids",
          :number_of_samples => 4,
          :sample_origin => "the moon",
          :sample_description => "A chunk of moon-cheese."
        }
      end

      it "should save a valid submission" do
        submission = Scheduler::Submission.new(params)
        count = Scheduler::Submission.count
        submission.save
        Scheduler::Submission.count.should == count + 1
      end
    end
  end

  describe "/" do
    it "should redirect to /scheduler" do
      get "/"
      last_response.status.should == 302
    end
  end

  describe "/queue" do
    describe "get" do
      it "should be successful" do
        get "/queue"
        last_response.should be_ok
      end
    end
  end

  describe "/calendar" do
    describe "get" do
      it "should be successful" do
        get "/calendar"
        last_response.should be_ok
      end

      it "should show the embedded calendar" do
        get "/calendar"
        last_response.body.should =~ /<\/iframe>/
      end
    end
  end
end
