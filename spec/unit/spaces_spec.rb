require 'spaces'
require 'database_connection'
describe Spaces do
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
