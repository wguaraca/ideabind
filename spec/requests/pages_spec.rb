require 'spec_helper'

describe "Pages" do
  
	it "should have the right links on the page" do
  	visit root_path
  	expect(page).to have_title("IdeaBind")
  	# click_link "About"
  	# expect(page).to have_title(full_title('About'))



  end
end
