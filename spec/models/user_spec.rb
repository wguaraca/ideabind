require 'spec_helper'

describe User do

	before { @user = User.new(
			name: "Example User", 
			email: "user@example.com",
			password: "foobar12", 
			password_confirmation: "foobar12") }

	subject { @user }

	describe "with valid attributes" do

		it { should be_valid }

		sym_arr = %i(admin pins name email id encrypted_password
								 reset_password_token sign_in_count 
								 last_sign_in_ip reputation skill_1 skill_2 
								 skill_3 profile_id)

		sym_arr.each { |sym| it { should respond_to(sym) } }

		describe "with email having mixed case" do
			before { @user.email = "fOOloh@funNy.COm"}
			it { should be_valid}
		end

		describe "with admin attribute set to 'true'" do
			before do
				@user.save!
				@user.toggle!(:admin)
			end

			it { should be_admin }
		end

		describe "like valid email formats" do
			it "should be valid" do
	      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
	      addresses.each do |valid_address|
	        @user.email = valid_address
	        expect(@user).to be_valid
	      end
	    end
		end
	end

	describe "with invalid attributes such as" do
		describe "password" do
			describe "being too short" do
				before { @user.password = @password_confirmation = "foobar" }

				it { should_not be_valid }
			end

			describe "being too long" do
				before { @user.password = @password_confirmation = 'a'*100 }

				it { should_not be_valid }
			end

			describe "mismatch" do
				before { @user.password = 'mismatch' }

				it { should_not be_valid }
			end
		end

		describe "name" do
			describe "being empty" do

				before { @user.name = ' ' }

				it { should_not be_valid }
			end

			describe "being too long" do

				before { @user.name = 'a' * 51 }

				it { should_not be_valid }
			end
		end

		describe "email" do 
			describe "being empty" do

				before { @user.email = " " }

				it { should_not be_valid }
			end

			describe "being too long" do
				before { @user.email = 'b' * 50 + '.com' }

				it { should_not be_valid }
			end

			describe "having bad format" do
				it "should be invalid" do
		      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
		                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
		      addresses.each do |invalid_address|
		        @user.email = invalid_address
		        expect(@user).not_to be_valid
		      end
		    end
			end
		end
	end

	describe "pins associations" do
		before { @user.save }
		let!(:older_pin) do
			FactoryGirl.create(:pin, user: @user, created_at: 1.day.ago)
		end
		let!(:newer_pin) do
			FactoryGirl.create(:pin, user: @user, created_at: 1.hour.ago)
		end

		it "should have the right microposts in the right order" do
			expect(@user.pins.to_a).to eq [newer_pin, older_pin]
		end

		it "should destroy associated pins" do
			pins = @user.pins.to_a
			@user.destroy
			expect(pins).not_to be_empty
			pins.each do |pin|
				expect(Pin.where(id: pin.id)).to be_empty
			end
		end
	end
end