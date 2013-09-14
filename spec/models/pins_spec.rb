require 'spec_helper'

describe Pin do
	let(:user) { FactoryGirl.create(:user) }
	before do
		@pin = user.pins.build(description: "Loren ipsum haba daba mana")
	end

	subject { @pin }

	sym_arr = %i(description user_id start_date end_date title user)
	sym_arr.each { |sym| it { should respond_to(sym) } }

	its(:user) { should eq user }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @pin.user_id = nil }
		it { should_not be_valid }
	end

	describe "with blank description" do 
		before { @pin.description = " " }
		it { should_not be_valid }
	end

	describe "with description that is too long" do
		before { @pin.description = "a" * 141 }
		it { should_not be_valid }
	end
end