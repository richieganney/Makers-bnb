require_relative '../web_helpers'

# As a seller,
# So I can make dollar dollar bills,
# I want to be able to approve requests
feature 'User can approve a request' do
  scenario 'approve request 'do
    sign_up_as_test
    add_test_space
    click_button 'Sign out'
    test_user_id = DatabaseConnection.query("SELECT user_id FROM users WHERE email = 'test@example.com';")
    test_space_id = DatabaseConnection.query("SELECT space_id FROM spaces WHERE title = 'funky apartment';")
    fakeuser2 = DatabaseConnection.query(
      "INSERT INTO users (first_name)
       VALUES ('james')
       RETURNING user_id;"
    )
    request = DatabaseConnection.query("INSERT INTO requests (guest, host, space) VALUES(
        '#{fakeuser2[0]['user_id']}', '#{test_user_id[0]['user_id']}', '#{test_space_id[0]['space_id']}') RETURNING request_id, approved;")
    visit('/requests')
    click_button 'accept request'
    except(page).to have_content('Request approved')
  end
end