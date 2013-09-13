require 'spec_helper'

describe Pin do
	let(:user) { FactoryGirl.create(:user) }
	before do
		@pin = Pin.new(description: "Loren ipsum haba daba mana", user_id: user.id)
	end

	subject { @pin }

	sym_arr = %i(description user_id start_date end_date title)
	sym_arr.each { |sym| it { should respond_to(sym) } }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @pin.user_id = nil }
		it { should_not be_valid }
	end
end