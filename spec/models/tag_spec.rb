require 'spec_helper'

describe Tag do
	let(:user) { FactoryGirl.create(:user) }
	let(:idea) { FactoryGirl.create(:idea, owner: user) }
	let(:update) { FactoryGirl.create(:update, user: user, idea: idea)}
  let(:tag) { Tag.create(name: "Bunny") }
  let(:updatetagging) { update.updatetaggings.create(tag_id: tag.id)}
  let(:ideatagging) { idea.ideataggings.create(tag_id: tag.id)}

  before do
	# tag.save
		ideatagging.save
		updatetagging.save
	end

  subject { tag }

  it { should be_valid }

  it { should respond_to :name }
  it { should respond_to :updates }
  it { should respond_to :updatetaggings } 
  it { should respond_to :ideas }
  it { should respond_to :ideataggings }
  it { should respond_to :safe_to_destroy? }

 	describe "stuff saved" do
 		it { expect(user).not_to be_new_record }
 		it { expect(idea).not_to be_new_record }
 		it { expect(update).not_to be_new_record }
 		it { expect(tag).not_to be_new_record }
 		it { expect(updatetagging).not_to be_new_record }
 	end

  describe "validations" do

  	describe "tag name can't be empty" do
  		let(:tag1) { Tag.create(name:"") }

  		it { expect(tag1).not_to be_valid }
  	end

  	describe "tag name should be unique" do

  		before do 
  			@tag1 = Tag.create(name: "Funny") 
  	    @tag2 = Tag.create(name: "Funny") 
  	  end

  		it { expect(@tag1).to be_valid }
  		it { expect(@tag2).not_to be_valid }
  	end

  end

  describe "associations" do

  	describe "tag updates should include update" do
  		it { expect(tag.updates).to include(update) }
  	end

  	describe "update tags should include tag" do
  		it { expect(update.tags).to include(tag) }
  	end

  	describe "tag ideas should include idea" do
  		it { expect(tag.ideas).to include(idea) }
  	end

  	describe "idea tags should include tag" do
  		it { expect(idea.tags).to include(tag) }
  	end

  	

  	describe "destroy" do
	  	describe "all updates" do
	  		before { tag.updates.destroy_all }

	  		describe "tag should have an update OR an idea associated with it" do
		  		it { expect(tag.safe_to_destroy?).to be_false }
		  	end
	  	end

	  	describe "all ideas" do
		  	before { tag.ideas.destroy_all }

		  	describe "tag should have an update OR an idea associated with it" do
		  		it { expect(tag.safe_to_destroy?).to be_false }
		  	end
		  end

		  describe "all ideas and updates" do
		  	before do
		  		tag.updates.destroy_all
		  		tag.ideas.destroy_all
		  	end

		  	describe "tag should have an update OR an idea associated with it" do
		  		it { expect(tag.safe_to_destroy?).to be_true }
		  	end
		  end
		end
  end
end

