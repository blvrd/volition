ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require 'minitest/mock'
require 'webmock/minitest'
Dir["#{Rails.root}/test/support/*.rb"].each {|file| require file }

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
