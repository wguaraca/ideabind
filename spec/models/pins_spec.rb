require 'spec_helper'

describe Pin do
	let(:user) { FactoryGirl.create(:user) }
	before do
		@pin = Pin.new(content: "Loren ipsum", user_id: user.id)
	end

	subject { @pin }

	it { should respond_to(:description) }
	it { should respond_to(:user_id) }

end