require 'spec_helper'
# require 'ruby_debug'

describe Comment do
	let(:user) { FactoryGirl.create(:user)}

	let(:comment) { user.comments.build(content: 'a' * 141, update_id: 1) }
	subject { comment }

	describe "should respond to" do
		sym_arr = %i(id user_id content update_id par_comment_id
			created_at rating upvote downvote helpful! helpful?
	  	 helpful? replies parent destroy)#parent)
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

		describe "parent should have no parent" do
			it { expect(parent.parent).to eq nil }
		end
		describe "kid should have no replies" do
			let(:arr) { kid.replies.to_a }
			it { arr.each { |reply| expect(reply).to eq nil } }
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

		describe "tree" do
			let(:parent1) {FactoryGirl.create(:comment, user: user) }
			let(:kid1) { FactoryGirl.create(:comment, user: user ) }
			let(:kid2) { FactoryGirl.create(:comment, user: user ) }

			before do
				parent1.replies << kid1
				parent1.replies << kid2
			end

			# describe "where kids have equal rating but kid2 has earlier creation times" do
			# 	before do # use update_attributes instead?
			# 		kid1.created_at = 1.day.ago
			# 		kid2.created_at = 1.hour.ago

			# 		kid1.rating = 10
			# 		kid2.rating = 10

			# 		kid1.save
			# 		kid2.save
			# 	end

			# 	describe "kid 2 should come before kid 1" do
			# 		let(:kids) { parent1.replies.to_a }

			# 		it { expect(kids).to eq [kid2, kid1] }
			# 	end
			# end

			describe "where kids have equal creation times but kid2 has higher rating" do
				before do
					kid1.created_at = 1.day.ago
					kid2.created_at = kid1.created_at

					kid1.rating = 5
					kid2.rating = 10

					kid1.save
					kid2.save
				end

				describe "kid 2 should come before kid 1" do
					let(:kids) { parent1.replies }

					it { expect(kids).to eq [kid2, kid1] }
				end
			end

			describe "where kid2 has higher rating but has later creation times" do
				before do
					kid1.created_at = 1.hour.ago
					kid2.created_at = 1.day.ago

					kid1.rating = 5
					kid2.rating = 10

					kid1.save
					kid2.save
				end

				describe "kid 2 should come before kid 1" do
					let(:kids) { parent1.replies }

					it { expect(kids).to eq [kid2, kid1] }
				end
			end



		end

		describe "destroy method" do
			describe "on parent" do
				before { parent.destroy }

				describe "shouldn't delete parent" do
					it { expect(parent).to_not eq nil }
				end
				
				describe "should only delete the contents" do
					it { expect(parent.content).to eq nil }
				end
			end

			describe "on kid" do
				before { kid.destroy }

				describe "should leave no trace of the kid" do
					let(:arr) { kid.replies.to_a }
					it { arr.each { |reply| expect(reply).to eq nil } }
				end
			end
		end
	end
end

