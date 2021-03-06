require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User signs in" do 

	before(:each) do 
		User.create(:email => "test@test.com",
					:password => 'test',
					:password_confirmation => 'test')
	end

	scenario "with correct credentials" do 
		visit '/'
		expect(page).not_to have_content("Welcome, test@test.com")
		sign_in('test@test.com', 'test')
		expect(page).to have_content("Welcome, test@test.com")
	end

	scenario "with incorrect credentials" do 
		visit '/'
		expect(page).not_to have_content("Welcome, test@test.com")
		sign_in('test@test.com', 'wrong')
		expect(page).not_to have_content("Welcome, test@test.com")
	end

end

feature 'User signs out' do 

	before(:each) do 
		User.create(:email => "test@test.com",
					:password => 'test',
					:password_confirmation => 'test')
	end

	scenario 'while being signed in' do 
		sign_in('test@test.com', 'test')
		click_button "Sign Out"
		expect(page).to have_content("Good bye!")
		expect(page).not_to have_content("Welcome, test@test.com")
	end

end

feature 'User forgets password' do 

	before(:each) do 
		User.create(:email => "test@test.com",
					:password => 'test',
					:password_confirmation => 'test')
	end

	scenario 'user clicks on forgotten password' do
		sign_in('test@test.com', 'wrong')
		click_link 'Forgotten Password'
		expect(page).to have_content("Please enter the email used for login")
		expect(page).not_to have_content("Welcome, test@test.com")
	end


end