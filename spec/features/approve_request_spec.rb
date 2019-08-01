require_relative '../web_helpers'

# As a seller,
# So I can make dollar dollar bills,
# I want to be able to approve requests
feature 'User can approve a request' do
  scenario 'approve request 'do
    sign_up_as_test
    add_test_space
    test_user_id = DatabaseConnection.query("SELECT * FROM users WHERE email = 'test@example.com';")
    test_space_id = DatabaseConnection.query("SELECT * FROM spaces WHERE title = 'funky apartment';")
    fakeuser2 = DatabaseConnection.query(
      "INSERT INTO users (first_name, last_name)
       VALUES ('james', 'palmer')
       RETURNING user_id;"
    )
    request = DatabaseConnection.query("INSERT INTO requests (guest, host, space, requested_date) VALUES(
        '#{fakeuser2[0]['user_id']}', '#{test_user_id[0]['user_id']}', '#{test_space_id[0]['space_id']}, '2019-08-01') RETURNING request_id, approved;")
    visit('/requests')
    click_button 'accept'
    except(page).to have_content('status: approved')
  end
end
