require 'spec_helper'

describe "Pages" do

	it "should have the right links on the page" do

    subject { page }

  	visit root_path
  	expect(page).to have_title("IdeaBind") 

  	click_link "About"
  	expect(page).to have_title("IdeaBind") 

    page.first(:link, "IdeaBind").click
    expect(page).to have_content("Welcome to IdeaBind")

    within('div.footer') do  # *|* Currently failing.
      click_link("IdeaBind") 
      expect(page).to have_content("Welcome to IdeaBind")
    end

		click_link "Home"
		expect(page).to have_content("Welcome to IdeaBind") 

    click_link "Login"
    expect(page).to have_content("Email")
   end

  # Needs more work?

  subject { page }

  shared_examples_for "all static pages" do
    # it { should have_selector('h1', text: heading) }
    # it { should have_title(page_title) }
    it { should have_link "Home" }
    it { should have_link "About" }
    it { should have_link "IdeaBind" }
    it { should have_link "Awesome Team" }  # *|* Need to change later.
  end

  describe "Home page" do
    before { visit root_path }
    # let(:heading)    { 'Welcome to IdeaBind' }
    # let(:page_title) { 'IdeaBind' }
    
    it_should_behave_like "all static pages"
  
  end

  describe "About page" do
    before { visit about_path }
    
    it { should have_selector('h5', text: "Wilson Guaraca")}
    it { should have_selector('h5', text: "Allen Mack")}
    it { should have_selector('h5', text: "Sam Peprah")}
    it { should have_selector('h5', text: "Edderic Ugaddan")}
    it_should_behave_like "all static pages"
  end

  describe "Forgot password page" do
    before { visit new_user_password_path } 

    it { should have_content "Forgot your password?" }
    it_should_behave_like "all static pages"
  end

  describe "Browse challenges" do 
    before { visit pins_path }

    it { should have_content "Challenges" }
    it_should_behave_like "all static pages"
  end
end
