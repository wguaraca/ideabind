require 'spec_helper'

describe "Authentication" do 
	before { visit root_path }

	subject { page }

	it { should have_link "Sign up Now"}
	it { should have_link "Home"}
	it { should have_link "Login"}
	it { should have_link "About"}
	it { should have_link "IdeaBind"}
	it { should have_link "Awesome Team"}
	it { should have_link "Browse Challenges"}

	describe "signin" do 
		before { click_link "Login" }

		it { should have_link "Home"}
		it { should have_link "About"}
		it { should_not have_link('Edit Profile') }
		it { should_not have_link('Settings') }
		it { should_not have_link('Sign out') }
	end

end