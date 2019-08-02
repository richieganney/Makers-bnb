require_relative '../test_helper'

feature 'adding a listing' do
  feature 'a user can add a listing' do
    scenario 'a user fills out the forms to add a listing' do
      visit('/spaces/add')
      fill_in('title', with: 'funky apartment')
      fill_in('description', with: 'this is a nice apartment downtown')
      fill_in('address', with: '123 Fake St')
      fill_in('price_per_night', with: '99.99')
      click_button 'List my space'
      expect(page).to have_content "funky apartment"
    end

  end
end
