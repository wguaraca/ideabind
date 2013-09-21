require 'spec_helper'
# require 'pp'

describe WhoRatedCommentRel do
	let(:user)    { FactoryGirl.create(:user) }
	let(:comment) { FactoryGirl.create(:comment) }
	let(:voting_rel) do
		# comment.who_rated_comment_rels.build(user_id: user.id)
		user.who_rated_comment_rels.build(comment_id: comment.id) 
	end

	subject { voting_rel }

	it { should be_valid }


	describe "follower methods" do

		it { should respond_to(:user_id) }
		it { should respond_to(:comment_id) }
		its(:comment) { should eq comment }
		its(:user)    { should eq user }
	end
end
