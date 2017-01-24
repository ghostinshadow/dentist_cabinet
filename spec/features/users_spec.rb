require 'rails_helper'
require 'pry'
RSpec.describe "Users", type: :feature do
	describe "login page" do
    before(:all){ 
      @user ||= create(:user) }

    it "should visit login_path" do
      visit new_user_session_path
      expect(page).to have_css("#user_email")
      expect(page).to have_content("Увійти в систему")
    end

    it "should include form" do
      visit new_user_session_path
      expect(page).to have_field("user_email")
      expect(page).to have_field("user_password")
      expect(page).to have_button("Увійти")
    end

    describe "successfull login", :js => true  do

      it "works! (now write some real specs)" do
        visit new_user_session_path
        within("#new_user") do
          fill_in('user_email', :with => @user.email)
          fill_in('user_password', :with => @user.password)

          click_button("Увійти")
        end
        expect(page).to have_css('li', count: 30)
      end
    end

    describe "login with wrong credentials" , :js => true do

      it "fails!" do
        user = build :user
        visit new_user_session_path
        within("#new_user") do
          fill_in('user_email', :with => user.email)
          fill_in('user_password', :with => user.password)
          click_button("Увійти")
        end

        expect(page).to have_css("#user_email")
      end
    end
  end
end