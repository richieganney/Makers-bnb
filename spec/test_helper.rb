require_relative './database_connection_setup'
require_relative '../lib/database_connection'

def test_helper
  # this clears the spaces and users table in the test environment for us
  DatabaseConnection.query('TRUNCATE spaces, users CASCADE;')

end
