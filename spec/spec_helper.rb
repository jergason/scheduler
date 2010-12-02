require File.join(File.dirname(__FILE__), "..", "scheduler.rb")

require 'rack/test'
require 'rspec'
require 'sinatra'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false
