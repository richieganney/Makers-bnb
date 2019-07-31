require 'request'
require 'database_connection'
require_relative '../test_helper'

describe Request do
  before(:each) do
    test_helper
  end
  describe "#accept" do
    it "changes the approval status of the request to true" do
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
      request = DatabaseConnection.query("INSERT INTO requests (guest, host, space) VALUES(
          '#{fakeuser1[0]['user_id']}', '#{fakeuser2[0]['user_id']}', '#{fakespace1[0]['space_id']}') RETURNING request_id, approved;")
      changed_request = Request.approve(request[0]['request_id'])
      expect(changed_request.approved).to eq true
    end
  end
  describe "#reject" do
    it "changes the approval status of the request to false" do
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
      request = DatabaseConnection.query("INSERT INTO requests (guest, host, space) VALUES(
          '#{fakeuser1[0]['user_id']}', '#{fakeuser2[0]['user_id']}', '#{fakespace1[0]['space_id']}') RETURNING request_id, approved;")
      changed_request = Request.reject(request[0]['request_id'])
      expect(changed_request.approved).to eq false
    end
  end
end
