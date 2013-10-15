require 'spec_helper'

describe Idea do
	let(:user) { FactoryGirl.create(:user) }
	let(:idea) { Idea.create(title: "Learn Flamenco Guitar", 
		description: "Go through Sabicas pieces", 
		location: "Santa Barbara, CA") }

	before do
		idea.owner = user
		user.owned_ideas << idea
		idea.collaborators << user
		idea.save
	end

	subject{ idea }

	it { should respond_to :owner }
	it { should respond_to :collaborators }
	it { should respond_to :location }
	it { should respond_to :updates }
	it { should respond_to :rating }
	it { should respond_to :title }
	it { should respond_to :description }
	it { should respond_to :ideataggings }
	it { should respond_to :tags }
	it { should respond_to :tags_tmp }   # Used for string hack!
	it { should respond_to :build_ideatags }
	it { should respond_to :collaborators_tmp }

	it { should be_valid }
	it { expect(user).to be_valid }
	it { expect(idea).to be_valid }

	describe "owner_id should be user id" do
		it { expect(idea.owner_id).to eq user.id }
	end

	describe "owner should be user" do
		it { expect(idea.owner).to eq user }
	end

	describe "user's idea should be the idea" do
		it { expect(user.owned_ideas.to_a[0]).to eq idea }
	end

	describe "user should be a collaborator" do
		it { expect(idea.collaborators.to_a[0]).to eq user }
	end

	describe "validations:" do
		describe "owner_id should exist" do
			before { idea.owner_id = nil }
			it { should_not be_valid }
		end

		describe "title should exist" do
			before { idea.title = nil }
			it { should_not be_valid }
		end

		describe "description should exist" do
			before { idea.description = nil }
			it { should_not be_valid }
		end

		describe "rating should default to 0" do
			it { expect(idea.rating).to eq 0 }
		end

		describe "location should exist" do
			before { idea.location = nil }
			it { should_not be_valid }
		end

		describe "collaborators_tmp can't be blank" do
			# before { collaborators_tmp.}
			it "is a pending example"
		end
	end

	describe "adding an update:" do
		let(:update1) { FactoryGirl.create(:update, user: user, idea: idea) }
		let(:update2) { FactoryGirl.create(:update, user: user, idea: idea) }

		before { idea.updates << [update1, update2] }

		it { expect(update1).to be_valid }
		it { expect(update2).to be_valid }

		describe "update1's user should be user" do
			it { expect(update1.user).to eq user }
		end

		describe "update2's user should be user" do
			it { expect(update2.user).to eq user }
		end

		describe "idea's updates should be update1 and 2" do
			it { expect(idea.updates.to_a[0]).to eq update1 }
			it { expect(idea.updates.to_a[1]).to eq update2 }
		end

		describe "update1's and 2's idea should be idea" do
			it { expect(update1.idea).to eq idea }
			it { expect(update2.idea).to eq idea }
		end

		describe "prepare for deletion: " do
		
			before { @updates = idea.updates.to_a }

			let(:update1_id) { @updates[0].id }
			let(:update2_id) { @updates[0].id }
			let(:idea_id) { idea.id }

			it { expect(@updates).not_to be_empty }

			describe "first update should be update" do
				it { expect(@updates[0]).to eq update1}
			end
			
			describe "idea should NOT be nil" do
				it { expect(idea).not_to be_nil }
			end   

			describe "destroy" do
				
				before { idea.destroy!	 } 

				it "idea should be nil" do
					expect(Idea.where(id: idea_id)).to be_empty
				end
				
				it "shouldn't erase updates (copy) var" do
					expect(@updates).not_to be_empty
				end

				it { expect(Update.where(id: update1.id)).to be_empty }
				it { expect(Update.where(id: update2.id)).to be_empty }

			end
		end
	end

	describe "helper methods" do
		describe "build_ideatags" do
			before do 
				idea.tags_tmp = "follow money guns" 
				idea.build_ideatags
			end

			describe "should create the tags" do
				let(:arr) { Array.new }
				before { idea.tags.to_a.each { |tag| arr << tag.name } }
				
				it "should include name 'follow'" do
					expect(arr).to include("follow")
				end

				it "should include name 'money'" do
					expect(arr).to include("money")
				end

				it "should include name 'guns'" do
					expect(arr).to include("guns")
				end

				describe "tag count should be 3" do
					it { expect(Tag.count).to eq 3 }
				end

				describe "create new idea and replicate a tag" do
					let(:idea1) { Idea.create(title: "Roller Skating in the Park", 
																	description: "Skill development", 
																	location: "Santa Barbara, CA") }
					let(:arr1) { Array.new }

					before do
						idea1.owner_id = user.id
						idea1.tags_tmp = "follow sun gun"
						idea1.save
						idea1.build_ideatags
						idea1.tags.to_a.each { |tag| arr1 << tag.name } 
					end

					describe "should create two new tags" do
						it "should include name 'follow'" do
							expect(arr1).to include("follow")
						end

						it "should include name 'sun'" do
							expect(arr1).to include("sun")
						end

						it "should include name 'gun'" do
							expect(arr1).to include("gun")
						end

						describe "tag count should be 5" do
							it { expect(Tag.count).to eq 5 }
						end
					end
				end
			end
		end
	end
end
