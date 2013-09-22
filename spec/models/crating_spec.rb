require 'spec_helper'

describe Crating do
  let(:rater) { FactoryGirl.create(:user) }
  let(:rated_comment) { FactoryGirl.create(:comment) }

	let(:crating) do
	  rater.cratings.build(rated_comment_id: rated_comment.rated_comment_id, vote_type: "up")
	end

	subject { crating }

  it { should be_valid }

  describe "follower methods" do
  	it { should respond_to(:rater) }
  	it { should respond_to(:rated_comment) }
  	it { should respond_to(:vote_type)}

  	its(:rater) { should eq rater }
  	its(:rated_comment) { should eq rated_comment }
  end

  describe "when rater id is not present" do 
  	before { crating.rater_id = nil }
  	it { should_not be_valid}
  end

  describe "when rated comment id is not present" do 
  	before { crating.rated_comment_id = nil }
  	it { should_not be_valid}
  end

  

	describe "when improper value for vote_type" do
		describe "like not being present" do 
	  	before { crating.vote_type = nil }
  	
	  	it { should_not be_valid}
	  end
  	
  	describe "like a two character" do
			before { crating.vote_type = "ab"}
			
			it { should_not be_valid }
		end
	end

	describe "when proper value for vote_type" do
		describe "such as up" do
			before { crating.vote_type = "up" }
			it { should be_valid }
		end

		describe "such as down" do
			before { crating.vote_type = "down" }
			it { should be_valid }
		end
	end
end
