ENV["RAILS_ENV"] ||= "test"
if ENV["COVERGE"]
  require "simplecov"
  SimpleCov.start "rails"
end

require_relative "../config/environment"

require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors) unless ENV["COVERGE"]

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
