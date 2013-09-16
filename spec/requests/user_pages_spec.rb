require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		let!(:p1)  { FactoryGirl.create(:pin, user: user, description: "Avra Kadavra") }
		let!(:p2)  { FactoryGirl.create(:pin, user: user, description: "Kebables Kadavra") }

		before do
			visit root_path 

			click_on 'Login'
			fill_in 'user_email',  with: user.email
			fill_in 'user_password', with: user.password

			click_on 'Sign in'
		end

		describe 'pins' do
			it { should have_content(p1.description) }
			it { should have_content(p2.description) }
			it { should have_content(user.pins.count) }
		end
	end
end