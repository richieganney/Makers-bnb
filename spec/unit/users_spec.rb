require 'user'

describe User do

 describe '.add' do
    it('adds a new user to the database') do
      expect(User.add(email: 'test@example.com', first_name: 'Test', last_name: 'Example', password: 'testing123', mobile: '123456789')).to be_a User
    end
  end
end
      