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
	# it { should_not have_link('Settings') }  # 	*|* for future?
	it { should_not have_link('Logout') }
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
				fill_in "user_email",    with: user.email 
				fill_in "user_password", with: user.password
				click_button 'Sign in'
			end

			it { should have_link('Edit Profile', href: edit_user_registration_path) }
			it { should have_link('Logout',     href: destroy_user_session_path) }
			it { should have_selector('div.alert.alert-notice', text: 'Signed in successfully') }

			# describe "accessing 'new'" do    # *|* Page seems to not render the view completely.
			# 	before { get new_user_session_path }
			# 	specify { response.should have_selector('div.alert.alert-alert', text: 'You are already signed in.') }
			# end

			# describe "accessing 'create'" do  # *|* Page seems to not render the view completely.
			# 	before { post user_session_path }
			# 	specify { response.should redirect_to(root_url) }
			# end

			describe "followed by signout" do
				before { click_link 'Logout' }

					it { should_not have_link('Edit Profile', href: edit_user_registration_path) }
					it { should_not have_link('Logout',     href: destroy_user_session_path) }
					it { should have_link("Sign up Now",			href: new_user_registration_path) }
					it { should have_link("Login",            href: new_user_session_path) }
					it { should have_selector('div.alert.alert-notice', text: 'Signed out successfully') }
			end
		end

		describe "authorization" do
			describe "for non-signed-in users" do
				let(:user) { FactoryGirl.create(:user) }

				describe "when attempting to visit a protected page" do 
					before do
						visit edit_user_password_path
						fill_in 'user_email',    with: user.email
						fill_in 'user_password', with: user.password
						click_button "Sign in"
					end

					describe "after signing in" do
						it 'should render the desired protected page' do
							expect(page).to have_content "You are already signed in."
						end
					end
				end
			end
		end
	end
end