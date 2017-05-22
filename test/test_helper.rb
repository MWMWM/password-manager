require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'

DatabaseCleaner.strategy = :transaction

class ActiveSupport::TestCase
  setup { DatabaseCleaner.start }
  teardown { DatabaseCleaner.clean }
end

