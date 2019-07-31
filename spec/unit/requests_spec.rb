require 'spaces'
require 'database_connection'
require 'requests'
require_relative '../test_helper'

describe Request do

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



end
