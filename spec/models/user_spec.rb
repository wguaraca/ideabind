require 'spec_helper'

describe User do

	before do
	 @user = User.new(
			name: "Example User", 
			email: "user@example.com",
			password: "foobar12", 
			password_confirmation: "foobar12") 
	end

	subject { @user }

	describe "with valid attributes" do

		it { should be_valid }

		sym_arr = %i(admin pins name email id encrypted_password
								 reset_password_token sign_in_count 
								 last_sign_in_ip reputation skill_1 skill_2 
								 skill_3 cratings rated_comments
								 rated? rate! comments updates ideabinds) # feed? rater_id

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

	describe "comment rating" do
  	# let(:user) { FactoryGirl.create(:user)}
  	let(:comment_b) { FactoryGirl.create(:comment) }

  	describe "upvote nil comment should be illegal" do
  		before { @user.save }

  		it { expect {@user.rate!(nil, "up").to raise error } }
  	end
  	
  	describe "upvote" do
	  	before do
	  	  @user.save
	  		@user.rate!(comment_b, "up") 
	  	end

	  	it { should be_rated(comment_b) }
	  	its(:rated_comments) { should include(comment_b)} 	
	  end

	  describe "downvote" do
	  	before do
	  		@user.save
	  		@user.rate!(comment_b, "down") 
	  	end

	  	it { should be_rated(comment_b) }
	  	its(:rated_comments) { should include(comment_b)} 	
	  end

	  describe "upvoting should increase rating by 1" do
				before do
				@user.save
				@user.rate!(comment_b, "up")
			end

			describe "and user-rating relationship should exist" do
	  		it { expect { user.cratings.find_by(rated_comment_id: comment_b.id) }.to_not eq nil }

	  		describe "and its vote_type should be 'up'" do
	  		end
	  	end
			
			describe "then upvoting again" do
				before { @user.rate!(comment_b, "up") }

				describe "should destroy rating-user relationship" do
					subject { @user.cratings.find_by(rated_comment_id: comment_b.id) }

					it { should eq nil }
				end

				describe "should negate the upvote" do
					subject { comment_b.rating }
					it { should eq 0 }
				end

			 	describe "then another upvote should increase rating by 1" do
			 		before { @user.rate!(comment_b, "up")}
					subject { comment_b.rating } 
					it { should eq 1 }
					
					describe "and user-rating relationship should exist" do
			  		it { expect { @user.cratings.find_by(rated_comment_id: comment_b.id) }.to_not eq nil }
			  	end
				end
			end			

			describe "then downvote" do
				before { @user.rate!(comment_b, "down") }

				describe "should update comment rating rel vote_type to down" do

					subject { @user.cratings.find_by(rated_comment_id: comment_b.id).vote_type }
					it { should eq "down"}
				end
			end
	  end

	  describe "downvote should decrease rating by 1" do
	  	before do
	  		@user.save
	  		@user.rate!(comment_b, "down")
	  	end
	  	
	  	subject { comment_b.rating }

	  	it { should eq -1 }

	  	describe "and user-rating relationship should exist" do
	  		let(:crating) { @user.cratings.find_by(rated_comment_id: comment_b.id) }
	  		it { expect { crating }.to_not eq nil }

	  		describe "and vote_type should be 'down'" do
	  			# it { expect { crating.vote_type }.to eq "down" }

	  			subject { crating.vote_type }

	  			it { should eq "down"}
	  		end
	  	end
	  	describe "then downvoting again" do
	  		before { @user.rate!(comment_b, "down") }

				describe "should destroy rating-user relationship" do
					subject { @user.cratings.find_by(rated_comment_id: comment_b.id) }
					it { should eq nil }
				end

				describe "should negate the upvote" do

					subject { comment_b.rating }
					it { should eq 0 }
				end
	
				describe "and finally downvoting one more time should decrease rating by 1" do
			  	it { expect{@user.rate!(comment_b, "down")}.to change{comment_b.rating}.from(0).to(-1) }
			  	describe "and user-rating relationship should exist" do
			  		it { expect { user.cratings.find_by(rated_comment_id: comment_b.id) }.to_not eq nil }
			  	end
			  end
			end

			describe "then upvote" do
				before { @user.rate!(comment_b, "up") }

				describe "should update comment rating rel" do
					subject { @user.cratings.find_by(rated_comment_id: comment_b.id) }
					it { should_not eq nil }
				end

				describe "should update comment rating rel vote_type to up" do
					subject { @user.cratings.find_by(rated_comment_id: comment_b.id).vote_type }
					it { should eq "up"}
				end

				describe "then rating should be 1" do
					subject { comment_b.rating }
					it { should eq 1 }
				end
			end
	  end
  end
end