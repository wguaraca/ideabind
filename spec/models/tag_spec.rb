require 'spec_helper'

describe Tag do
  let(:tag) { Tag.new(name: "Bunny") }
  subject { tag }

  it { should be_valid }

  it { should respond_to :name }
  it { should respond_to :updates }
  it { should respond_to :updatetaggings } 

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
end

