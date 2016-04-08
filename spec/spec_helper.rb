require 'rack/test'
require 'rspec'
require 'database_cleaner'
require 'sequel'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../app.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

# For RSpec 2.x and 3.x
RSpec.configure do |config|
  # TEST_DB = Sequel.connect("sqlite://feed_test.db")
  config.include RSpecMixin
  # config.before(:suite) do
  #   DatabaseCleaner.orm = "sequel"
  #   DatabaseCleaner.strategy = :transaction
  #   DatabaseCleaner.clean_with(:truncation)
  # end
  #
  # config.before do
  #   DatabaseCleaner[:sequel, {connection: TEST_DB}].start
  # end
  #
  # config.after do
  #   DatabaseCleaner[:sequel, {connection: TEST_DB}].clean
  # end
end
