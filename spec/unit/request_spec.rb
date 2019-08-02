require 'spaces'
require 'database_connection'
require 'request'
require_relative '../test_helper'



describe Request do

  before(:each) do
    test_helper
  end

  describe '.create' do

    it 'returns a request when a new one is made' do
      # methods contained in testhelper.rb
      sample_host = User.add(email: 'test@example.com', first_name: 'Test', last_name: 'Example', password: 'testing123', mobile: '123456789')
      sample_space = Spaces.add("123 fake street", "title", "description" , 100 ,sample_host.user_id,"2018-07-19", "2019-07-19" )
      sample_guest = User.add(email: 'test2@example.com', first_name: 'Test2', last_name: 'Example2', password: 'testing123', mobile: '123456789')
      request = Request.create(guest: sample_guest, host: sample_host, space: sample_space, requested_date: "2019-9-24")
      expect(request.guest).to eq(sample_guest)
      expect(request.space).to eq(sample_space)
      expect(request.host).to eq(sample_host)
    end
  end

  describe ".approve" do
    it "changes the approval status of the request to true" do
        fakeuser1 = setup_sample_host
        fakeuser2 = setup_sample_guest
        fakespace1 = setup_sample_space
        request = DatabaseConnection.query("INSERT INTO requests (guest, host, space, requested_date) VALUES(
            '#{fakeuser1[0]['user_id']}', '#{fakeuser2[0]['user_id']}', '#{fakespace1[0]['space_id']}', '2019-08-01') RETURNING request_id, approved;")
        changed_request = Request.approve(request[0]['request_id'])
        expect(changed_request.approved).to eq true
    end
  end

  describe ".reject" do
    it "changes the approval status of the request to false" do
      fakeuser1 = setup_sample_host
      fakeuser2 = setup_sample_guest
      fakespace1 = setup_sample_space
      request = DatabaseConnection.query("INSERT INTO requests (guest, host, space) VALUES(
          '#{fakeuser1[0]['user_id']}', '#{fakeuser2[0]['user_id']}', '#{fakespace1[0]['space_id']}') RETURNING request_id, approved;")
      changed_request = Request.reject(request[0]['request_id'])
      expect(changed_request.approved).to eq false
    end
  end
  describe ".all_user_received" do
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
      expect(requests_received_by_user2[0].host.user_id).to eq fakeuser2[0]["user_id"]
    end
  end
  describe ".all_user_sent" do
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
      expect(requests_sent_by_fakeuser1[0].guest.user_id).to eq fakeuser1[0]["user_id"]
    end
  end
end
