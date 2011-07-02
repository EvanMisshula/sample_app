require 'spec_helper'

describe "LayoutLinks" do #1

    it "should have a Home page at '/'" do #2
      get '/'
      response.should have_selector('title',:content=> "Home")
    end#2-
    it "should have a Contact page at '/contact'" do #3
      get '/contact'
      response.should have_selector('title',:content=> "Contact")
    end #3-
    it "should have a About page at '/about'" do #4
      get '/about'
      response.should have_selector('title',:content=> "About")
    end #4-
    it "should have a Help page at '/help'" do #5
      get '/help'
      response.should have_selector('title',:content=> "Help")
    end #5-
    it "should have a signup page at '/signup'" do #6
      get '/signup'
      response.should have_selector('title',:content=> "Sign up")
    end #6-
 describe "when not signed in" do # 7
    it "should have a signin link" do #8
      visit root_path
      response.should have_selector("a",:href => signin_path,:content => "Sign in")
    end #8-
  end #7-
  describe "when signed in" do #9

    before(:each) do #10
      @user = Factory(:user)
      visit signin_path
      fill_in :email, :with => @user.email
      fill_in :password, :with  => @user.password
      click_button
    end #10-

    it "should have a signout link" do #11
      visit root_path
      response.should have_selector("a",:href => signout_path,:content => "Sign out")
    end #11-
    it "should have a profile link" do #12
      visit root_path
      response.should have_selector("a",:href => user_path(@user),:content => "Profile")      
    end #12 -

end #9-
end #1-
