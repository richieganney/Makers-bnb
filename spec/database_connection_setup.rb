require_relative '../lib/database_connection.rb'

  if ENV['ENVIRONMENT'] == 'test'
    puts "Working on test db ..."
    DatabaseConnection.setup('makers_bnb_test')
    DatabaseConnection.query('TRUNCATE users, spaces;')
  else
    puts "Working on production db ..."
    DatabaseConnection.setup('makers_bnb')
  end
