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
      sample_host = setup_sample_host
      sample_space = setup_sample_space
      sample_guest = setup_sample_guest
      request = Request.create(guest: sample_guest[0]['user_id'], host: sample_host[0]['user_id'], space: sample_space[0]['space_id'])
      expect(request.guest).to eq(sample_guest[0]['user_id'])
      expect(request.space).to eq(sample_space[0]['space_id'])
      expect(request.host).to eq(sample_host[0]['user_id'])
    end
  end

  describe "#accept" do
    it "changes the approval status of the request to true" do
        fakeuser1 = setup_sample_host
        fakeuser2 = setup_sample_guest
        fakespace1 = setup_sample_space
        request = DatabaseConnection.query("INSERT INTO requests (guest, host, space) VALUES(
            '#{fakeuser1[0]['user_id']}', '#{fakeuser2[0]['user_id']}', '#{fakespace1[0]['space_id']}') RETURNING request_id, approved;")
        changed_request = Request.approve(request[0]['request_id'])
        expect(changed_request.approved).to eq true
    end
  end
  
  describe "#reject" do
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
end
