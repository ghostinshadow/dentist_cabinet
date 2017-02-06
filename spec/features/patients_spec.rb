require 'rails_helper'

RSpec.describe "Users", type: :feature do
  describe "login page" , js: true do
    before(:all){
      @user ||= create(:user)
      @session = Capybara::Session.new(:chrome, DentistCabinet::Application)
      @session.visit new_user_session_path
      @session.within("#new_user") do
        @session.fill_in('user_email', :with => @user.email)
        @session.fill_in('user_password', :with => @user.password)

        @session.click_button("Увійти")
      end
      auth_key = @session.driver.browser.manage.all_cookies[0][:value]
      binding.pry
       Capybara.current_session.driver.header('Set-Cookie', '_dentist_cabinet_session=' + auth_key)
    }

    before(:each){
      @session.visit root_path
    }

    describe "patient form", js: true do

      it "should open when plus patient button pressed" do
      	binding.pry
        @session.find(:css, '.glyphicon.glyphicon-user').click
        expect(@session).to have
      end

    end

    describe "patient creation", js: true do
      it "should open form"
    end

    xit "should visit login_path" do
      visit new_user_session_path
      expect(page).to have_css("#user_email")
      expect(page).to have_content("Увійти в систему")
    end

    xit "should include form" do
      visit new_user_session_path
      expect(page).to have_field("user_email")
      expect(page).to have_field("user_password")
      expect(page).to have_button("Увійти")
    end

    describe "successfull login", :js => true  do

      xit "works! (now write some real specs)" do
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

      xit "fails!" do
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
