feature 'signing in' do
  scenario 'a user can sign in' do
    user = User.add(email: 'test@example.com', first_name: 'Test', last_name: 'Example', password: 'testing123', mobile: '123456789')
    visit('/')
    # save_and_open_page
    click_link("here")
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'testing123')
    click_button("Submit")
    save_and_open_page
    expect(page).to have_content("Welcome back, Test")
  end
end
    