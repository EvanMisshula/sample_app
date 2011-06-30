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
describe "Post 'create'" do #12

    describe "failure" do #13


      before(:each) do #14
        @attr = { :name => "", :email => "", :password => "", :password_confirmation => "" }
      end #14-

      it "should not create a user" do # 15
        lamda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end #15-
  
      it "should have the right title" do #16
        post :create, :user => @attr
        response.should have_selector("title", :content =>"Sign up")
      end #16-

      it "it should render the 'new' page" do #17
        post :create, :user => @attr
        response.should have_template('new')
      end #17-
     end #13-
     
     describe "success" do  #18

      before(:each) do #19
        @attr = { :name => "New User", :email => "user@example.com", :password => "foobar", :password_confirmation => "foobar" }
      end #19-

      it "should create a user" do # 20
        lamda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end #20-

      it "it should redirect to the user 'sho' page" do #21
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end #21-
      it "should have a welcome message" do #22
        post :create, :user => @attr
        flash[:success].should =~ /welcome to the sample app/i
      end #22-

     end #18-
    end #12-
 end #1-
