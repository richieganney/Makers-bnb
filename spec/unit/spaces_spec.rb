require 'spaces'
require 'database_connection'
require_relative '../test_helper'

describe Spaces do
  before(:each) do
    test_helper
  end
  describe '.all' do
    it 'returns all spaces' do
      DatabaseConnection.query("INSERT INTO spaces (title) VALUES('Test Listing');")
      spaces = Spaces.all
      expect(spaces.length).to eq 1
      expect(spaces.first).to be_a Spaces
      expect(spaces.first.title).to eq 'Test Listing'
    end
  end

  describe '#add method' do
    it "should add an entry to the database" do
      result1 = DatabaseConnection.query(
        "INSERT INTO users (first_name)
         VALUES ('dan')
         RETURNING user_id;"
      )
      newspace = Spaces.add("123 fake street", "title", "description" , 100 ,result1[0]['user_id'],"2020-07-19", "2021-07-19" )
      expect(newspace.address).to eq  "123 fake street"
    end
  end

  describe '.find' do
    it 'should create a space object' do
      spaceId = setup_sample_space
      insert_two_booked_nights(spaceId[0]['space_id'])
      space = Spaces.find(spaceId[0]['space_id'])
      expect(space.booked_nights).to eq "{2019-07-31,2019-08-01}"
    end
  end
  
  describe '#filter_by_date' do
    it ' should return spaces whose availability listing contains the whole of the booking period' do
      sample_space1 = setup_sample_space_with_available_dates('2019-10-01','2019-11-01')
      sample_space2 = setup_sample_space_with_available_dates('2019-10-01','2019-12-01')
      filtered_spaces = Spaces.filter_by_date('2019-10-6','2019-11-06')
      expect(filtered_spaces.length).to eq 1
      expect(filtered_spaces[0].space_id).to eq sample_space2[0]['space_id']
    end
  end
end
