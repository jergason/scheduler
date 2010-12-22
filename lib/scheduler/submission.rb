#Model for submissions
require "pony"
module Scheduler
  class Submission
    include DataMapper::Resource

    property :id, Serial
    property :name, String
    property :principal_investigator, String
    property :department, String
    property :email, String
    property :phone_number, String
    property :sample_type, String
    property :number_of_samples, Integer
    property :sample_origin, String
    property :sample_description, Text
    property :created_on, DateTime, :default => lambda { |r, p| Time.now }
    property :updated_on, DateTime, :default => lambda { |r, p| Time.now }
    property :display, Boolean, :default => true

    def mail(to, from, options={})
      Pony.mail(:to => to.to_s,
                :from => from.to_s,
                :subject => "New Signup for The Orbitrap",
                :body => "#{name} (email: #{email}) has signed up to use the orbitrap. See here for more details.")
    end

    before :save do
      updated_on = Time.now
    end
  end
end

DataMapper.finalize
