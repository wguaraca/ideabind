require 'spec_helper'

describe Crating do
  let(:rater) { FactoryGirl.create(:user) }
  let(:rated_comment) { FactoryGirl.create(:comment) }
	let(:crating) do
	  rater.cratings.build(rated_comment_id: rated_comment.rated_comment_id)
	end

	subject { crating }

  it { should be_valid }

  describe "follower methods" do
  	it { should respond_to(:rater) }
  	it { should respond_to(:rated_comment) }

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

  
end
