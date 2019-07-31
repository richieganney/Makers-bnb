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
  describe "#all_user_received" do
    it "it queries DB and returns array of all requests received by a user i.e. where the user is the host" do
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
      fakeuser3 = DatabaseConnection.query(
        "INSERT INTO users (first_name)
         VALUES ('rob')
         RETURNING user_id;"
      )
      fakespace1 = DatabaseConnection.query(
        "INSERT INTO spaces (title)
         VALUES ('cool')
         RETURNING space_id;"
      )
      request1 = DatabaseConnection.query("INSERT INTO requests (guest, host, space) VALUES(
          '#{fakeuser1[0]['user_id']}', '#{fakeuser2[0]['user_id']}', '#{fakespace1[0]['space_id']}') RETURNING request_id, approved;")
      request3 = DatabaseConnection.query("INSERT INTO requests (guest, host, space) VALUES(
              '#{fakeuser1[0]['user_id']}', '#{fakeuser2[0]['user_id']}', '#{fakespace1[0]['space_id']}') RETURNING request_id, approved;")
      request2 = DatabaseConnection.query("INSERT INTO requests (guest, host, space) VALUES(
          '#{fakeuser1[0]['user_id']}', '#{fakeuser3[0]['user_id']}', '#{fakespace1[0]['space_id']}') RETURNING request_id, approved;")
      requests_received_by_user2 = Request.all_user_received(fakeuser2[0]["user_id"])
      expect(requests_received_by_user2.length).to eq 2
      expect(requests_received_by_user2[0].host).to eq fakeuser2[0]["user_id"]
    end
  end
  describe "#all_user_sent" do
    it "it queries DB and returns array of all requests sent by a user i.e. where the user is the guest" do
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
      fakeuser3 = DatabaseConnection.query(
        "INSERT INTO users (first_name)
         VALUES ('rob')
         RETURNING user_id;"
      )
      fakespace1 = DatabaseConnection.query(
        "INSERT INTO spaces (title)
         VALUES ('cool')
         RETURNING space_id;"
      )
      request1 = DatabaseConnection.query("INSERT INTO requests (guest, host, space) VALUES(
          '#{fakeuser3[0]['user_id']}', '#{fakeuser2[0]['user_id']}', '#{fakespace1[0]['space_id']}') RETURNING request_id, approved;")
      request3 = DatabaseConnection.query("INSERT INTO requests (guest, host, space) VALUES(
              '#{fakeuser1[0]['user_id']}', '#{fakeuser2[0]['user_id']}', '#{fakespace1[0]['space_id']}') RETURNING request_id, approved;")
      request2 = DatabaseConnection.query("INSERT INTO requests (guest, host, space) VALUES(
          '#{fakeuser1[0]['user_id']}', '#{fakeuser3[0]['user_id']}', '#{fakespace1[0]['space_id']}') RETURNING request_id, approved;")
      requests_sent_by_fakeuser1 = Request.all_user_sent(fakeuser1[0]["user_id"])
      expect(requests_sent_by_fakeuser1.length).to eq 2
      expect(requests_sent_by_fakeuser1[0].guest).to eq fakeuser1[0]["user_id"]
    end
  end
end
