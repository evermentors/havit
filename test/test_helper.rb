ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  include Devise::TestHelpers
  fixtures :all
  # Add more helper methods to be used by all tests here...
end
