require 'spec_helper'

describe "Pages" do

	it "should have the right links on the page" do

    subject { page }

  	visit root_path
  	expect(page).to have_title("ideabind") 

  	click_link "About"
  	expect(page).to have_title("ideabind") 

    page.first(:link, "ideabind").click
    expect(page).to have_content("Welcome to ideabind")

    within('div.footer') do  # *|* Currently failing.
      click_link("ideabind") 
      expect(page).to have_content("ideabind")
    end

		click_link "Home"
		expect(page).to have_content("Welcome to ideabind") 

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
    it { should have_link "ideabind" }
    it { should have_link "Awesome Team" }  # *|* Need to change later.
  end

  describe "Home page" do
    before { visit root_path }
    # let(:heading)    { 'Welcome to ideabind' }
    # let(:page_title) { 'ideabind' }
    
    it_should_behave_like "all static pages"

    describe "sign in as an authorized user" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        visit new_user_session_path 
        fill_in 'user_email',    with: user.email
        fill_in 'user_password', with: user.password
        click_button "Sign in"
      end

      it { should have_content "Signed in successfully." }
      it { should have_content "Messages" }
      it { should have_content "Comments" }
      it { should have_content "Popular Tags" }
      it { should have_content "Shares" }
      it { should have_link "Bind It" }

      describe "clicking Bind it" do
        before { click_link "Bind It" }

        it { should have_selector('h3', "Idea Description") }
        it { should have_content "Title" }
        it { should have_content "Location" }
        it { should have_content "Tags" }
        it { should have_content "Description" }

        it { should have_selector('input', "Create") }

        describe "clicking Create" do
          describe "with invalid info" do
            before { click_button "Create" }

            it { should have_content "Failed" }
            it { should have_selector('h3', "Idea Description") }
            it { should have_content "Title" }
            it { should have_content "Location" }
            it { should have_content "Tags" }
            it { should have_content "Description" }

          end
        end
      end
    end
  
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
