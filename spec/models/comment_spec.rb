require 'spec_helper'
# require 'ruby_debug'

describe Comment do
	let(:user) { FactoryGirl.create(:user)}

	let(:comment) { user.comments.build(content: 'a' * 141, update_id: 1) }
	subject { comment }

	describe "should respond to" do
		sym_arr = %i(id user_id content update_id par_comment_id
			created_at rating upvote downvote helpful! helpful?
	  	 helpful? replies parent)#parent)
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

		describe "content length too short" do
			before { comment.content = 'abc'}

			it { should_not be_valid }
		end
	end

	describe "parent-child relationship: " do

		let(:parent) { user.comments.create(content:"parent" + 'a'*150, update_id: 1) }
		let(:kid) { user.comments.create(content:"child" + 'a'*150, update_id: 1) }

		before { parent.replies << kid }

		describe "parent should have right content" do
			it { expect(parent.content).to eq "parent" + 'a'*150 } 
		end

		describe "kid should have right content" do
			it { expect(kid.content).to eq "child" + 'a'*150 }
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
			it { expect(kid.content).to eq "child" + 'a'*150 } 
		end

		describe "the child of the parent" do
			it { expect(parent.replies.to_a[0].content).to eq "child" + 'a'*150}
		end

		describe "the parent of the child" do
			it { expect((kid.parent).content).to eq "parent" + 'a'*150}
			# it { expect((kid.par_comment).content).to eq "parent" + 'a'*150}
		end

		describe "the content of the kid through association = 'child'" do
			# debugger
			subject { parent.replies.find_by(id: kid.id).content }
			it { should eq "child" + 'a'*150 }
		end

		describe "parent-child relationship should not be nil" do
			it { expect(parent.replies).to_not eq nil }

			describe "and what's returned is the child comment" do
				let(:arr) { parent.replies.to_a }

				it { expect(arr[0].content).to eq "child" + 'a'*150}

				describe "and its length should be 1" do
					it { expect(arr.length).to eq 1 }
				end
			end
		end

		
		describe "and child of that" do
		end
	end

	describe "parent comment" do
	end


	describe "when deleted" do
	end
end

