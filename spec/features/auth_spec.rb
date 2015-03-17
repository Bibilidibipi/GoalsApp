require 'spec_helper'
require 'rails_helper'

feature "create user" do

  scenario "has new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up user" do
     before(:each) do
       visit new_user_url
       fill_in 'username', with: "testing_username"
       fill_in 'password', with: 'password'
       click_on "Create User"
     end

     scenario "redirects to goals page after signup" do
       expect(page).to have_content "Goals"
     end

     scenario "shows username on page after signup" do
       expect(page).to have_content "testing_username"
     end

  end
end

feature "login user" do

  scenario "has login page" do
    visit new_session_url
    expect(page).to have_content "Log In"
  end

  feature "logging in user" do

    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      visit new_session_url
      fill_in 'username', with: user.username
      fill_in 'password', with: user.password
      click_on "Log In"
    end

    scenario "redirects to goals page after signup" do
      expect(page).to have_content "Goals"
    end

    scenario "shows username on page after signup" do
      expect(page).to have_content user.username
    end
  end
end

feature "logout user" do

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    visit user_url(user)
  end

  scenario "user does not start out logged in" do
    expect(page).to_not have_content user.username
  end

  scenario "user is redirected to login page" do
    expect(page).to have_content "Log In"
  end
end
