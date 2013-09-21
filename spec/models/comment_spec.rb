require 'spec_helper'

describe Comment do

	let(:comment) { FactoryGirl.create(:comment) }
	subject { comment }

	describe "should respond to" do
		sym_arr = %i(id usr_id content upd_id com_id
			created_at rating who_rated)
		sym_arr.each { |sym| it { should respond_to sym } }
	end

	it { should be_valid }

	describe "is illegal when" do

		describe "usr_id is not present" do
			before { comment.usr_id = nil}

			it { should_not be_valid }
		end	
		
		describe "content is not present" do
			before { comment.content = nil}

			it { should_not be_valid }
		end

		describe "upd_id is not present" do
			before { comment.upd_id = nil}

			it { should_not be_valid }
		end		
	end

	describe "usr_id, upd_id can be used for mass-assignment" do
		good_comment = Comment.create(usr_id: "100", 
																	upd_id: "100",
																	content: "Trololol")

		subject { good_comment }

		it { should be_valid }
	end

	describe "when deleted"
end

