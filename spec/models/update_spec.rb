require 'spec_helper'

describe Update do

	sym_arr = %i(user description idea comments title rating
		user_id)
	sym_arr.each { |sym| it {should respond_to sym} }

	let(:user) { FactoryGirl.create(:user) }
	let(:update) { FactoryGirl.create(:update, user: user)}
	subject { update }

	it { should be_valid }

	describe "validations:" do
		describe "user_id should exist" do
			before { update.user_id = nil }
			it { should_not be_valid }
		end

		describe "title should exist" do
			before { update.title = nil }
			it { should_not be_valid }
		end

		describe "description should exist" do
			before { update.description = nil }
			it { should_not be_valid }
		end

		describe "rating should default to 0" do
			it { expect(update.rating).to eq 0 }
		end

		describe "idea should exist" do
			before { update.idea = nil }
			it { should_not be_valid }
		end
	end

	describe "comments" do
		let(:comment1) { FactoryGirl.create(:comment, user: user) }
		let(:comment2) { FactoryGirl.create(:comment, user: user) }
		let(:comment3) { FactoryGirl.create(:comment, user: user) }

		before do
			comment1.rating = 7
			comment1.helpfulness = true
			
			comment2.rating = 10
			
			comment3.rating = 3
			comment3.helpfulness = true

			comment1.save
			comment2.save
			comment3.save

			update.comments << [comment1, comment2, comment3]
		end

		describe "comments should be valid" do
			it { expect(comment1).to be_valid }
			it { expect(comment2).to be_valid }
			it { expect(comment3).to be_valid }
		end

		describe "should be ordered by HELPFULNESS and then RATING" do
			let(:sorted) { update.sort_default_comments.to_a }
	
			it { expect(sorted).to eq [comment1,comment3,comment2] }
		end
	end
end
