require 'spec_helper'

describe "Users" do #1
   
   describe "signup" do #2

     describe "failure" do #3

    it "should not make a new user" do #4
        lambda do
        visit signup_path
        fill_in "Name",        :with => ""
        fill_in "Email",       :with => ""
        fill_in "Password",    :with => ""
        fill_in "Confirmation",:with => ""
        click_button
        response.should render_template('users/new')
        response.should have_selector("div#error_explanation")
        end.should_not change(User,:count)
    end #4-
  end #3-

      describe "success" do #5

    it "should make a new user" do #6
        lambda do
        visit signup_path
        fill_in "Name",        :with => "Example User"
        fill_in "Email",       :with => "user@example.com"
        fill_in "Password",    :with => "foobar"
        fill_in "Confirmation",:with => "foobar"
        click_button
        response.should render_template('users/show')
        response.should have_selector("div.flash.success", :content =>"Welcome")
        end.should change(User,:count).by(1)
      end #6-
   end #5- 
 end #2-
 describe "sign in/out" do #7
    describe "failure" do #8
      it "should not sign a user in" do #9
        visit signin_path
        fill_in :email, :with =>""
        fill_in :password, :with =>""
        click_button
        response.should have_selector("div.flash.error", :content =>"Invalid")
    end #9-
  end #8-

  describe "success" do #10
      it "should sign a user in and out" do #11
        user = Factory(:user)
        visit signin_path
        fill_in :email, :with =>user.email
        fill_in :password, :with =>user.password
        click_button
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end #11-
  end #10 -
 end #7-
end #1-
