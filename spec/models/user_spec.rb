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

		sym_arr = %i(name email id encrypted_password
								 reset_password_token sign_in_count 
								 last_sign_in_ip reputation 
								 skill_1 skill_2 skill_3 )

		sym_arr.each { |sym| it { should respond_to(sym) } }

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
				before { @user.password = @user.password_confirmation = "foobar" }
					
				it { should_not be_valid }
			end

			describe "mismatch" do
				before { @user.password = "foobar123" }

				it { should_not be_valid }
			end
		end

		describe "name" do
			describe "being empty" do
				before { @user.name = " " }

				it { should_not be_valid }
			end

			describe "being too long" do
				before { @user.name = 'a' * 50 }

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
end