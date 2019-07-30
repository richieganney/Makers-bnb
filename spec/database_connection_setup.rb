require_relative '../lib/database_connection.rb'

  if ENV['ENVIRONMENT'] == 'test'
    DatabaseConnection.setup('makers_bnb_test')
    DatabaseConnection.query('TRUNCATE users, spaces CASCADE;')
  else
    DatabaseConnection.setup('makers_bnb')
  end
