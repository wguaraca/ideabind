require 'spec_helper'

shared_examples_for "all pages" do

	it { should have_link "IdeaBind" }
	it { should have_link "Home"}
	it { should have_link "About"}
	it { should have_link "Awesome Team"}

end

shared_examples_for "failed login attempt" do

	it { should have_selector('div.alert.alert-alert', 
													text: 'Invalid') }	
	it { should_not have_link('Edit Profile') }
	it { should_not have_link('Settings') }
	it { should_not have_link('Sign out') }
end

describe "Authentication" do 
	before { visit root_path }

	subject { page }

	it { should have_link "Sign up Now"}
	it { should have_link "Login"}
	it { should have_link "Browse Challenges"}
	it_should_behave_like "all pages"

	describe "signin" do 
		before { click_link "Login" }	

		describe "with invalid information" do
			before { click_button 'Sign in' }  # submit empty info

			it_should_behave_like "failed login attempt"

			describe "after visiting another page" do
				before { click_link "Home" }
				it { should_not have_selector('div.alert.alert-alert', 
													text: 'Invalid') }

			end
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in user_email,    with: user.email 
				fill_in user_password, with: user.password
				click_button 'Sign in'
			end

			it { should have_link('Edit Profile',   href: edit_user_registration_path) }
			it { should have_link('Edit Profile',   href: edit_user_registration_path) }
		end
	end
end