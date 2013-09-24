require 'spec_helper'

describe "Multiple users and comments" do 
	let(:user1) { FactoryGirl.create(:user) }
	let(:user2) { FactoryGirl.create(:user) }
	let(:comment)	{ user1.comments.create(content: "funny bunny!", update_id:1) }
	
	describe "user1 upvotes comment: " do
		before { user1.rate!(comment, "up") }

		describe "rating should go up by 1" do
			it { expect(comment.rating).to eq 1 }
		end

		describe "crating between user1 and comment should have vote_type 'up'" do
			it { expect(user1.cratings.to_a[0].vote_type).to eq "up" }
		end	

		describe "user2 upvotes comment" do
			before { user2.rate!(comment, "up") }

			describe "expect comment rating to go up by 1" do
				it { expect(comment.rating).to eq 2 }
			end

			describe "crating between user2 and comment should have vote_type 'up'" do
				it { expect(user2.cratings.to_a[0].vote_type).to eq "up" }
			end	

			describe "then again user1 upvotes comment: " do
				before { user1.rate!(comment, "up") }

				describe "rating should go down by 1" do
					it { expect(comment.rating).to eq 1 }
				end

				describe "crating between user1 and comment should not exist" do
					it { expect(user1.cratings.where(rated_comment_id: comment.id)).to be_empty }
				end	

				describe "user1 upvotes comment one more time: " do
					before { user1.rate!(comment, "up") }

					describe "rating should be 2" do
						it { expect(comment.rating).to eq 2 }
					end

					describe "crating between user1 and comment should have vote_type 'up'" do
						it { expect(user1.cratings.to_a[0].vote_type).to eq "up" }
					end	

					describe "user2 upvotes comment: " do
						before { user2.rate!(comment, "up") }

						describe "expect comment rating to go up by 1" do
							it { expect(comment.rating).to eq 1 }
						end

						describe "crating between user2 and comment should not exist" do
							it { expect(user2.cratings.where(rated_comment_id: comment.id)).to be_empty }
						end
					end
				end
			end
		end
	end

	describe "user1 downvotes comment: " do
		before { user1.rate!(comment, "down") }

		describe "rating should go down by 1" do
			it { expect(comment.rating).to eq -1 }
		end

		describe "crating between user1 and comment should have vote_type 'down'" do
			it { expect(user1.cratings.to_a[0].vote_type).to eq "down" }
		end	

		describe "user2 downvotes comment" do
			before { user2.rate!(comment, "down") }

			describe "expect comment rating to go down by 1" do
				it { expect(comment.rating).to eq -2 }
			end

			describe "crating between user2 and comment should have vote_type 'down'" do
				it { expect(user2.cratings.to_a[0].vote_type).to eq "down" }
			end	

			describe "then again user1 downvotes comment: " do
				before { user1.rate!(comment, "down") }

				describe "rating should go down by 1" do
					it { expect(comment.rating).to eq -1 }
				end

				describe "crating between user1 and comment should not exist" do
					it { expect(user1.cratings.where(rated_comment_id: comment.id)).to be_empty}
				end	

				describe "user1 downvotes comment one more time: " do
					before { user1.rate!(comment, "down") }

					describe "rating should be 2" do
						it { expect(comment.rating).to eq -2 }
					end

					describe "user2 downvotes comment" do
						before { user2.rate!(comment, "down") }

						describe "expect comment rating to go down by 1" do
							it { expect(comment.rating).to eq -1 }
						end
					end
				end
			end
		end
	end

	describe "user1 downvotes comment: " do
		before { user1.rate!(comment, "down") }

		describe "rating should go down by 1" do
			it { expect(comment.rating).to eq -1 }
		end

		describe "crating between user1 and comment should have vote_type 'down'" do
			it { expect(user1.cratings.to_a[0].vote_type).to eq "down" }
		end	

		describe "user2 upvotes comment" do
			before { user2.rate!(comment, "up") }

			describe "expect comment rating to go up by 1" do
				it { expect(comment.rating).to eq 0 }
			end

			describe "crating between user2 and comment should have vote_type 'down'" do
				it { expect(user2.cratings.to_a[0].vote_type).to eq "up" }
			end	

			describe "then user1 upvotes comment: " do
				before { user1.rate!(comment, "up") }

				describe "rating should eq 2" do
					it { expect(comment.rating).to eq 2 }
				end

				describe "crating between user1 and comment should exist" do
					it { expect(user1.cratings.where(rated_comment_id: comment.id)).to_not be_empty }
				end	

				describe "user1 downvotes comment one more time: " do
					before { user1.rate!(comment, "down") }

					describe "rating should be 0" do
						it { expect(comment.rating).to eq 0}
					end

					describe "user2 upvotes comment" do
						before { user2.rate!(comment, "up") }

						describe "expect comment rating should be 1" do
							it { expect(comment.rating).to eq -1 }
						end
					end
				end
			end
		end
	end
end