require 'spec_helper'

describe UsersController do  #1
  render_views

  describe "GET 'new'" do  #2
    it "should be successful" do #3
      get 'new'
      response.should be_success
    end #3-
  
    it "should have the right title" do #4
      get 'new'
      response.should have_selector("title", :content => "Sign up")
  end #4-
 end #2-

  describe "GET 'show'" do #5
    
    before(:each) do  #6
      @user=Factory(:user)
    end #6-
    
    it "should be successful" do #7
      get :show, :id => @user
      response.should be_success
    end #7-

    it "should find the right user" do #8
      get :show, :id => @user
      assigns(:user).should == @user
    end #8-
   
    it "should have the right title" do #9
      get :show, :id => @user
      response.should have_selector("title",:content =>@user.name)
      end #9-
    it "should include the user's name" do #10
      get :show, :id => @user
      response.should have_selector("h1",:content =>@user.name)
      end #10-

    it "should have a profile image" do #11
      get :show, :id => @user
      response.should have_selector("h1>img",:class => "gravatar")
  end #11-
  end #5-
 end #1
