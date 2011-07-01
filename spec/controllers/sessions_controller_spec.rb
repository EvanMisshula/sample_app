require 'spec_helper'

describe SessionsController do #1
  render_views
  describe "GET 'new'" do #2
    it "should be successful" do #3
      get 'new'
      response.should be_success
    end #3-

    it "it should have the right title" do #4
      get 'new'
      response.should have_selector('title', :content => "Sign in")
    end #4-    
  end #2-
  
  describe "POST 'create'" do #5
    describe "invalid  signin" do  #6

      before(:each) do #7
        @attr = { :email => "email@example.com", :password =>"invalid"}
      end #7-

      it "should re-render the new page" do #8
        post :create, :session => @attr
        response.should render_template('new')
      end #8-
      it "should have the right title" do #9
        post :create, :session => @attr
        response.should have_selector("title", :content => "Sign in")
      end #9-
      it "should have a flash.now messagee" do #10
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end #10-
    end #6-
    describe "valid  signin" do  #11

      before(:each) do #12
        @user = Factory(:user)
        @attr = { :email => "email@example.com", :password =>"password"}
      end #12-
      
      it "should sign the user in" do #13
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end #13-

      it "should redirect to the user show page" do #14
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end #14-
    end #11-
  end #5-
  
  describe "DELETE 'destroy'" do #15

    it "should sign a user out" do #16
      test_sign_in(Factory(:user))
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end #16-
 end #15-
end #1-
