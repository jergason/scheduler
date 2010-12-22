require 'spec_helper'

def app
  @app ||= Sinatra::Application
end

describe "Scheduler" do
  include Rack::Test::Methods

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
      it "should work" do
        count = Scheduler::Submission.count(:display => true)
        parms = {}
        parms[:submission] = params
        post "/scheduler", parms
        last_response.status.should == 303
        Scheduler::Submission.count.should == count + 1
      end

      it "should display a flash message upon sucessful creation of a submission" do
        parms = {}
        parms[:submission] = params
        post "/scheduler", parms
        last_response.body.should =~ /Successfully signed up for the mass spec./i
      end

      it "should save a valid submission" do
        count = Scheduler::Submission.count
        submission = Scheduler::Submission.create(params)
        Scheduler::Submission.count.should == count + 1
      end

      after do
        Scheduler::Submission.last.destroy
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
    context "when issuing a get request" do
      it "should be successful" do
        get "/queue"
        last_response.should be_ok
      end

      it "should only display submissions set to display" do
        get "/queue"
        count = last_response.body.split.select { |i| i =~ /submission/ }.count
        Scheduler::Submission.count(:display => true).should == count
      end
    end

    context "when issuing a delete request" do
      before do
        Scheduler::Submission.create(params.merge({ :name => "Bob Cratchit" }))
      end
      let(:sub) { Scheduler::Submission.first(:name => "Bob Cratchit") }
      it "should delete an existing entry" do
        count = Scheduler::Submission.count(:display => true)
        delete "/queue", :id => sub.id
        Scheduler::Submission.count(:display => true).should == count - 1
      end

      after do 
        sub.destroy!
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
