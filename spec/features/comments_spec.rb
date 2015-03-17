require 'spec_helper'
require 'rails_helper'


feature "Comments" do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }

  before(:each) do
    visit new_session_url
    fill_in 'username', with: user1.username
    fill_in 'password', with: user1.password
    click_on "Log In"
  end

  feature "for users" do
    before(:each) do
      visit user_url(user2)
      click_on "Comment on user"
      fill_in "body", with: "you are amazing!"
      click_on "Submit Comment"
    end

    scenario "show on creation" do
      expect(page).to have_content "you are amazing!"
    end
  end

  feature "for goals" do
    before(:each) do
      click_on "New Goal"
      fill_in "body", with: "eat more"
      choose 'public'
      click_on "Create Goal"
      click_on "Back to #{user1.username}"
      click_on "eat more"
      click_on "Comment"
      fill_in "body", with: "that's a good goal!"
      click_on "Submit Comment"
    end
    scenario "show on creation" do
      expect(page).to have_content "that's a good goal!"
    end
  end
end
