def sign_up_as_test
    visit('/')
    fill_in('email', with: 'test@example.com')
    fill_in('first_name', with: 'Test')
    fill_in('last_name', with: 'Example')
    fill_in('password', with: 'testing123')
    fill_in('mobile', with: '123456789')
    click_button('Submit')
end

def sign_up_as_test_2
    visit('/')
    fill_in('email', with: 'test_2@example.com')
    fill_in('first_name', with: 'Test_2')
    fill_in('last_name', with: 'Example')
    fill_in('password', with: 'testing123')
    fill_in('mobile', with: '123456789')
    click_button('Submit')
end

def add_test_space
  visit('/spaces/add')
  fill_in('title', with: 'funky apartment')
  fill_in('description', with: 'this is a nice apartment downtown')
  fill_in('address', with: '123 Fake St')
  fill_in('price_per_night', with: '99.99')
  click_button 'submit'
end
