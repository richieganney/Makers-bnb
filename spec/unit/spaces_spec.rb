require 'spaces'
require 'database_connection'

describe Spaces do
  
  describe '.all' do
    it 'returns all spaces' do
      DatabaseConnection.query("INSERT INTO spaces (title, owner) VALUES('Test Listing', 1);")
      spaces = Spaces.all
      expect(spaces.length).to eq 1
      expect(spaces.first).to be_a Spaces
      expect(spaces.first.title).to eq 'Test Listing'
      expect(spaces.first.owner).to eq '1'
    end
  end

  describe  '#add method' do
    it "should add an entry to the database" do
      result1 = DatabaseConnection.query(
        "INSERT INTO users (first_name)
         VALUES ('dan')
         RETURNING user_id;"
      )
      newspace = Spaces.add("123 fake street", "title", "description" , 100 ,result1[0]['user_id'] )
      expect(newspace.address).to eq  "123 fake street"
    end
  end
end
