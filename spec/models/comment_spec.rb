require 'spec_helper'
# require 'ruby_debug'

describe Comment do
	let(:user) { FactoryGirl.create(:user)}

	let(:comment) { user.comments.build(content: "Luaupalooza", update_id: 1) }
	subject { comment }

	describe "should respond to" do
		sym_arr = %i(id user_id content update_id par_comment_id
			created_at rating upvote downvote helpful! helpful?
	  	 helpful? replies parent)
		sym_arr.each { |sym| it { should respond_to sym } }
	end	

	it { should be_valid }

	describe "validations" do

		describe "user_id is not present" do
			before { comment.user_id = nil}

			it { should_not be_valid }
		end	
		
		describe "content is not present" do
			before { comment.content = nil}

			it { should_not be_valid }
		end

		describe "update_id is not present" do
			before { comment.update_id = nil}

			it { should_not be_valid }
		end		

		describe "par_comment_id is not present" do
			before { par_comment_id = nil}

			it { should be_valid }
		end
	end

	describe "parent-child relationship: " do

		let(:parent) { user.comments.create(content:"parent", update_id: 1) }
		let(:kid) { user.comments.create(content:"child", update_id: 1) }

		before { parent.replies << kid }

		describe "parent should have right content" do
			it { expect(parent.content).to eq "parent" } 
		end

		describe "kid should have right content" do
			it { expect(kid.content).to eq "child" }
		end

		describe "ids shouldn't be nil" do
			it { expect(parent.id).to_not eq nil }
			it { expect(kid.id).to_not eq nil }
		end

		describe "user_id of each should be user_id" do
			it { expect(parent.user_id).to eq user.id }
			it { expect(kid.user_id).to eq user.id }
		end

		describe "child should have right content" do
			it { expect(kid.content).to eq "child" } 
		end

		describe "the child of the parent" do
			it { expect(parent.replies.to_a[0].content).to eq "child"}
		end

		describe "the parent of the child" do
			it { expect(kid.parent.content).to eq "child"}
		end

		describe "the content of the kid through association = 'child'" do
			# debugger
			subject { parent.replies.find_by(id: kid.id).content }
			it { should eq "child" }
		end

		describe "parent-child relationship should not be nil" do
			it { expect(parent.replies).to_not eq nil }

			describe "and what's returned is the child comment" do
				let(:arr) { parent.replies.to_a }

				it { expect(arr[0].content).to eq "child"}

				describe "and its length should be 1" do
					it { expect(arr.length).to eq 1 }
				end
			end
		end

		# user = FactoryGirl.create(:user)

		# comment = user.comments.build(content: "Luaupalooza", update_id: 1)
		# let(:second_comment) { user.comments.build(content: "second comment", update_id: 1) }
		# comment.replies.build(comment_id: second_comment.id)
		
		describe "and child of that" do
		end
	end

	describe "parent comment" do
	end

	

	# describe "user_id, update_id can be used for mass-assignment" do
	# 	good_comment = FactoryGirl.create(:comment, user_id: "100", 
	# 																update_id: "100",
	# 																content: "Trololol")

	# 	subject { good_comment }

	# 	it { should be_valid }
	# end

	describe "when deleted" do
	end
end

