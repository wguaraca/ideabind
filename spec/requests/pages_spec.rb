require 'spec_helper'

describe "Pages" do

	it "should have the right links on the page" do

  	visit root_path
  	expect(page).to have_title("IdeaBind") 

  	click_link "About"
  	expect(page).to have_title("IdeaBind") 

  	click_link "IdeaBind"
  	expect(page).to have_content("Welcome to IdeaBind")

		click_link "Home"
		expect(page).to have_content("Welcome to IdeaBind")  	

  end
end
