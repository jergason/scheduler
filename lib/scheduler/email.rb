require "pony"

module Scheduler
  module Email
    def self.mail(params, to, from)
      Pony.mail(:to => to,
                :from => from,
                :subject => "New Signup For Orbitrap",
                :body => "New signup for Orbitrap from #{params[:name]}, email: #{params[:email]}."
               )
    end
  end
end
