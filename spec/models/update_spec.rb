require 'spec_helper'

describe Update do

	sym_arr = %i(user description idea comments title rating
		user_id)
	sym_arr.each { |sym| it {should respond_to sym} }

	let(:user) { FactoryGirl.create(:user) }
	let(:idea) { FactoryGirl.build(:idea) }
	let(:update) { FactoryGirl.create(:update, user: user, idea: idea)}
	
	before do
	 	idea.owner = user 
	 	idea.updates << update
	 	idea.save
	end

	subject { update }

	it { should be_valid }
	it { expect(update.comments).to be_empty }

	describe "idea should be valid" do
		it { expect(idea).to be_valid }
	end

	describe "validations:" do
		describe "user_id should exist" do
			before { update.user_id = nil }
			it { should_not be_valid }
		end

		describe "title should exist" do
			before { update.title = nil }
			it { should_not be_valid }
		end

		describe "description should exist" do
			before { update.description = nil }
			it { should_not be_valid }
		end

		describe "rating should default to 0" do
			it { expect(update.rating).to eq 0 }
		end

		describe "idea should exist" do
			before { update.idea = nil }
			it { should_not be_valid }
		end
	end

	describe "comments" do
		let(:comment1) { FactoryGirl.create(:comment, user: user) }
		let(:comment2) { FactoryGirl.create(:comment, user: user) }
		let(:comment3) { FactoryGirl.create(:comment, user: user) }

		before do
			comment1.rating = 7
			comment1.helpfulness = true
			
			comment2.rating = 10
			
			comment3.rating = 3
			comment3.helpfulness = true

			comment1.save
			comment2.save
			comment3.save

			update.comments << [comment1, comment2, comment3]
		end

		it "comments should be valid" do
			expect(comment1).to be_valid 
			expect(comment2).to be_valid 
			expect(comment3).to be_valid 
		end

		it "should be ordered by HELPFULNESS and then RATING" do
			sorted = update.sort_default_comments.to_a 
	
			expect(sorted).to eq [comment1,comment3,comment2] 
		end

		describe "destroy update" do
			it "should destroy the comments" do
				
				update.destroy

				expect(Comment.where(id: comment1.id)).to be_empty
				expect(Comment.where(id: comment2.id)).to be_empty
				expect(Comment.where(id: comment3.id)).to be_empty

			end
		end

		describe "destroy comments" do
			before do
				comment1.destroy
				comment2.destroy
				comment3.destroy
			end

			it { expect(Comment.where(id: comment1.id)).to be_empty }
			it { expect(Comment.where(id: comment2.id)).to be_empty }
			it { expect(Comment.where(id: comment3.id)).to be_empty }
		end
	end

	describe "initialize for destroy:" do
		let(:comment) { FactoryGirl.create(:comment, user: user)}
		let(:kid1) { FactoryGirl.create(:comment, user: user)}

		# Interesting: "Owner can't be blank"
		let(:update1) { user.updates.create(title: "Me playing guitar", description: "The Most Evolved by John H. Clarke") }
		before do
			update.user = user
			update1.idea = idea
			update1.save
		end

		# debugger

		describe "update1 should be valid" do
			it { expect(update1).to be_valid }
		end

		describe "comment should be valid" do
			it { expect(comment).to be_valid }
		end

		describe "kid1 should be valid" do
			it { expect(kid1).to be_valid }
		end

		it "update1 comments should be empty" do
			expect(update1.comments).to be_empty
		end

		it "should have nothing as its first object" do
			expect(update1.comments.to_a[0]).to eq nil
		end
		
		describe "then add a comment to the update and a reply to that comment" do
			before do
			  update1.comments << comment
			  comment.replies << kid1  
			end

			describe "there should only be one element" do
				it { expect(update1.comments.length).to eq 1 }
			end

			describe "the only element should be comment" do
				it { expect(update1.comments.to_a[0]).to eq comment }
			end

			describe "comment replies length should be 1" do
				it { expect(comment.replies.length).to eq 1 }
			end

			describe "the kid should be kid" do
				it { expect(update1.comments.to_a[0].replies.to_a[0]).to eq kid1 }
			end

			describe "prepare" do
				# let(:comment_id) { comment.id }
				# let(:reply_id) { kid1.id }
				# let(:comments) { update1.comments.to_a }
				# let(:replies) { comments[0].replies.to_a }

				before do
					@comment_id = comment.id
					@reply_id = kid1.id
					@comments = update1.comments.to_a 
					@replies = @comments[0].replies.to_a
				end

				describe "comment_id should be comment.id" do
					it { expect(Comment.where(id: @comment_id).to_a[0]).to eq comment}
				end

				describe "destroy should erase its direct child comment nonetheless" do
					before { update1.destroy }
					it { expect(@comments).not_to be_empty }
					it { expect(@replies).not_to be_empty }
						
					it { expect(Comment.where(id: @comment_id)).to be_empty }		
					it { expect(Comment.where(id: @reply_id)).to be_empty }
					
				end
			end		
		end
	end
end
