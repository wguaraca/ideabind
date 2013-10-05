require 'spec_helper'

describe Updatetagging do

	let(:user) { FactoryGirl.create(:user) }
	let(:idea) { FactoryGirl.build(:idea, owner: user) }
	let(:update) { FactoryGirl.create(:update, user: user, idea: idea)}
	let(:tag) { FactoryGirl.create(:tag, name: "lol")}
	let(:updatetagging) { update.updatetaggings.create(tag_id: tag.id)}

 	
 	before { updatetagging.save }

	subject { updatetagging }

  it { should respond_to :update_id }
  it { should respond_to :tag_id }
  it { should be_valid }

  it { expect(user).to be_valid }
  it { expect(idea).to be_valid }
  it { expect(update).to be_valid }
  it { expect(tag).to be_valid }


  describe "validations" do
	  describe "tag_id should be present" do
	  	before { updatetagging.tag_id = nil }

	  	it { should_not be_valid }
	  end

	  describe "update_id should be present" do
	  	before { updatetagging.update_id = nil }

	  	it { should_not be_valid }
	  end
	end

	describe "associations" do
		describe "update tag should be tag" do
			it { expect(update.tags.to_a[0]).to eq tag }
		end

		describe "tag's update should be tag" do
			it { expect(tag.updates.to_a[0]).to eq update }
		end

		describe "finding updates" do

			it "should be able to find updates given a tag name" do
				expect(Tag.find_by_name('lol').updates).to include(update) 
			end

			it "should be able to find tag given partial tag name" do
				# expect(Tag.similar_to('lo').to_a[0].updates.to_a[0]).to eq update 
				expect(Tag.similar_to('lo')).to include(tag)
			end

			it "should be able to find corresponding updates given partial tag name" do
				expect(Tag.similar_to('lo').to_a[0].updates).to include(update)
			end

			describe "multiple updates and tags" do

				let(:update1) { FactoryGirl.create(:update, user: user, idea: idea)}
				let(:tag1) { FactoryGirl.create(:tag, name: "lola")}
				let(:updatetagging1) { update1.updatetaggings.create(tag_id: tag1.id) }

				let(:update2) { FactoryGirl.create(:update, user: user, idea: idea)}
				let(:tag2) { FactoryGirl.create(:tag, name: "negative")}
				let(:updatetagging2) { update1.updatetaggings.create(tag_id: tag2.id) }


				before { updatetagging1.save }

				it { expect(update1).to be_valid }
				it { expect(tag1).to be_valid }
				it { expect(updatetagging1).to be_valid }

				describe "updates_similar_to should return a list" do
					it { expect(Tag.updates_similar_to('lo').to_a).to eq [update, update1] }
				end
			end
		end

		describe "finding ideas" do

		end
	end
end
