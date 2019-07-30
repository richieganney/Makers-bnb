def sign_up_as_test
    fill_in('email', with: 'test@example.com')
    fill_in('first_name', with: 'Test')
    fill_in('last_name', with: 'Example')
    fill_in('password', with: 'testing123')
    fill_in('mobile', with: '123456789')
end