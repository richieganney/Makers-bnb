require 'spaces'

describe Spaces do
  describe '.all' do
    it 'returns all spaces' do
      DatabaseConnection.query("INSERT INTO spaces (title, owner) VALUES('Test Listing', 'test owner');")
      spaces = Spaces.all
      expect(spaces.length).to eq 1
      expect(spaces.first).to be_a Spaces
      expect(spaces.first.title).to eq 'Test Listing'
      expect(spaces.first.owner).to eq 'test owner'

    end
  end
end
