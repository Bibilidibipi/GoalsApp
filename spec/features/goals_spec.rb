require 'spec_helper'
require 'rails_helper'

feature "Creates goal" do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }

  scenario "redirects to login page when not logged in" do
    visit new_user_goal_url(user1)
    expect(page).to have_content "Log In"
  end

  feature "in correct scope" do
    before(:each) do
      visit new_session_url
      fill_in 'username', with: user1.username
      fill_in 'password', with: user1.password
      click_on "Log In"
      click_on 'New Goal'
      fill_in 'body', with: "eat more"
      choose 'uncompleted'
    end
    feature "when goal is public" do
      scenario "user can see goal" do
        choose 'public'
        click_on "Create Goal"

        expect(page).to have_content "eat more"
      end
    end

    feature "when goal is private" do
      before(:each) do
        choose 'private'
        click_on 'Create Goal'
      end

      scenario "other users can't see goal" do
        visit new_session_url
        fill_in 'username', with: user2.username
        fill_in 'password', with: user2.password
        click_on "Log In"
        visit user_url(user1)

        expect(page).to_not have_content "eat more"
      end

      scenario "user can see goal" do
        click_on "Back to #{user1.username}"
        expect(page).to have_content "eat more"
      end
    end
  end

  feature "shows completion option correctly" do
    before(:each) do
      visit new_session_url
      fill_in 'username', with: user1.username
      fill_in 'password', with: user1.password
      click_on "Log In"
      click_on 'New Goal'
      fill_in 'body', with: "eat more"
      choose 'public'
    end

    scenario "when completed" do
      choose 'completed'
      click_on "Create Goal"

      expect(page).to have_content "COMPLETED"
    end

    scenario "when not completed" do
      choose 'uncompleted'
      click_on "Create Goal"

      expect(page).to_not have_content "COMPLETED"
    end
  end
end
