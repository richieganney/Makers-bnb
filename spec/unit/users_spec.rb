require 'user'

describe User do

 describe '.add' do
    it('adds a new user to the database') do
      expect(User.add(email: 'test@example.com', first_name: 'Test', last_name: 'Example', password: 'testing123', mobile: '123456789')).to be_a User
    end
 end

  describe '.authenticate' do
    it('allows a user to sign into their account') do
      user = User.add(email: 'test@example.com', first_name: 'Test', last_name: 'Example', password: 'testing123', mobile: '123456789')
      authenticated_user = User.authenticate('test@example.com', 'testing123')

      expect(authenticated_user.first_name).to eq user.first_name
    end

    it 'returns nil given an incorrect email address' do
      user = User.add(email: 'test@example.com', first_name: 'Test', last_name: 'Example', password: 'testing123', mobile: '123456789')
  
      expect(User.authenticate('nottherightemail@me.com', 'testing123')).to be_nil
    end

    it 'returns nil given an incorrect password' do
      user = User.add(email: 'test@example.com', first_name: 'Test', last_name: 'Example', password: 'testing123', mobile: '123456789')
  
      expect(User.authenticate('test@example.com', 'wrongpassword')).to be_nil
    end
  end
end
      