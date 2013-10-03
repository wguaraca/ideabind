require 'spec_helper'

describe Ideabind do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:idea) { Idea.create(title: "Learn Flamenco Guitar", description: "Go through Sabicas pieces") }
  let(:collaborator_to_idea_rel) { user.ideabinds.create(collaborated_idea_id: idea.id)}

	before do
		idea.owner = user
		user.owned_ideas << idea
		idea.save
		# idea.collaborators << user
		# idea.updates << update
		# update.idea = idea
		# idea.save
	end

	subject { collaborator_to_idea_rel }

	it { should be_valid }

	it { should respond_to(:collaborator_id) }
	it { should respond_to(:collaborated_idea_id) }
	it { should respond_to(:owner?)}

	its(:collaborated_idea) { should eq idea}
	its(:collaborator)      { should eq user}

	describe "validations" do
		describe "collaborated idea should exist" do
			before { collaborator_to_idea_rel.collaborated_idea_id = nil}

			it { should_not be_valid }
		end

		describe "collaborator should exist" do
			before { collaborator_to_idea_rel.collaborator = nil}

			it { should_not be_valid }
		end
	end
	
end
