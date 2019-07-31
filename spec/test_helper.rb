require_relative './database_connection_setup'
require './lib/spaces'
require './lib/database_connection'
require './lib/request'

def test_helper
  # this clears the spaces and users table in the test environment for us
#   DatabaseConnection.query('TRUNCATE spaces, users CASCADE;')
  DatabaseConnection.query('TRUNCATE spaces, users, requests;')
end

def setup_sample_guest
  DatabaseConnection.query(
    "INSERT INTO users (first_name)
     VALUES ('richie')
     RETURNING user_id;"
  )
end

def setup_sample_host
  DatabaseConnection.query(
    "INSERT INTO users (first_name)
     VALUES ('dan')
     RETURNING user_id;"
  )
end

def setup_2_fake_users_1_fake_space
  fakeuser1 = DatabaseConnection.query(
    "INSERT INTO users (first_name)
     VALUES ('dan')
     RETURNING user_id;"
  )
  fakeuser2 = DatabaseConnection.query(
    "INSERT INTO users (first_name)
     VALUES ('james')
     RETURNING user_id;"
  )
  fakespace1 = DatabaseConnection.query(
    "INSERT INTO spaces (title)
     VALUES ('cool')
     RETURNING space_id;"
  )
end

def setup_sample_space(sample_host = setup_sample_host)
  DatabaseConnection.query(
    "INSERT INTO spaces (title, owner)
     VALUES ('shaggers landing', '#{sample_host[0]['user_id']}')
     RETURNING space_id;"
  )
end

def insert_two_booked_nights(space_id)
  DatabaseConnection.query(
    "UPDATE spaces SET booked_nights = '{2019-07-31, 2019-08-01}' WHERE space_id = #{space_id};"
  )
end
