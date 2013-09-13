require 'spec_helper'

describe User do
	describe "with valid attributes" do
		before { @user = User.new(
			name: "Example User", 
			email: "user@example.com",
			password: "foobar12", 
			password_confirmation: "foobar12") }

		subject { @user }

		it { should be_valid }

		sym_arr = %i(name email id encrypted_password
								 reset_password_token sign_in_count 
								 last_sign_in_ip )

		sym_arr.each { |sym| it { should respond_to(sym) } }
	end

	describe "with invalid attributes such as" do
		describe "password" do
			describe "being too short" do
				before { @user = User.new(
					name: "Example User", 
					email: "user@example.com",
					password: "foobar", 
					password_confirmation: "foobar") }

				it { should_not be_valid }
			end

			describe "being too long" do
				before { @user = User.new(
				name: "Example User", 
				email: "user@example.com",
				password: 'a'*100, 
				password_confirmation: 'a'*100) }

				it { should_not be_valid }
			end

			describe "mismatch" do
				before { @user = User.new(
				name: "Example User", 
				email: "user@example.com",
				password: "foobar12", 
				password_confirmation: "foobar12") }

				it { should_not be_valid }
			end
		end

		describe "name" do
			describe "being empty" do
				before { @user = User.new(
				name: "", 
				email: "user@example.com",
				password: "foobar11", 
				password_confirmation: "foobar11") }

				it { should_not be_valid }
			end

			describe "being too long" do
				before { @user = User.new(
				name: 'a' * 50, 
				email: "user@example.com",
				password: "foobar11", 
				password_confirmation: "foobar11") }

				it { should_not be_valid }
			end
		end

		describe "email" do 
			describe "being empty" do
				before { @user = User.new(
				name: "Funny Junk", 
				email: "",
				password: "foobar11", 
				password_confirmation: "foobar11") }

				it { should_not be_valid }
			end

			describe "being too long" do
				before { @user = User.new(
				name: "Funny Junk", 
				email: 'b' * 50 + '.com',
				password: "foobar11", 
				password_confirmation: "foobar11") }

				it { should_not be_valid }
			end

			describe "having bad format" do
				before { @user = User.new(
				name: "Jose Rizal", 
				email: "bad_email_example",
				password: "foobar11", 
				password_confirmation: "foobar11") }

				it { should_not be_valid }
			end
		end
	end
end