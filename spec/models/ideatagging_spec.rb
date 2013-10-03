require 'spec_helper'

describe Ideatagging do
	let(:user) { FactoryGirl.create(:user) }
	let(:idea) { FactoryGirl.create(:idea, owner: user) }
  let(:tag) { Tag.create(name: "Bunny") } 
  let(:ideatagging) { idea.ideataggings.create(tag_id: tag.id) }

  before { ideatagging.save }  # Weird that we need to save after create.
  subject { ideatagging }

  it { should be_valid }

  it { should respond_to :tag_id }
  it { should respond_to :idea_id }

  describe "stuff saved" do
  	it { expect(user).not_to be_new_record }
  	it { expect(idea).not_to be_new_record }
  	it { expect(tag).not_to be_new_record }
  	it { expect(ideatagging).not_to be_new_record }
  end

  describe "models should be valid" do
  	it { expect(user).to be_valid }
  	it { expect(idea).to be_valid }
  	it { expect(idea).to be_valid }
  end

  describe "validations" do
  	describe "tag_id can't be nil" do
	  	before { ideatagging.tag_id = nil }
	  	it { should_not be_valid }
	  end

  	describe "idea_id can't be nil" do
	  	before { ideatagging.idea_id = nil }
	  	it { should_not be_valid }
	  end
  end


  describe "associations" do
  	describe "idea tags should include tag" do
	  	it { expect(idea.tags).to include(tag)}
	  end

	  describe "tag ideas should include idea" do
	  	it { expect(tag.ideas).to include(idea)}
	  end
  end

end
