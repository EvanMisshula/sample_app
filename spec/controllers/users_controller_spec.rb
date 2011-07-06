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
      response.should have_selector('h1',:content =>@user.name)
      end #10-

    it "should have a profile image" do #11
      get :show, :id => @user
      response.should have_selector('h1>img',:class => "gravatar")
  end #11-
  end #5-
describe "Post 'create'" do #12

    describe "failure" do #13


      before(:each) do #14
        @attr = { :name => "", :email => "", :password => "", :password_confirmation => "" }
      end #14-

      it "should not create a user" do # 15
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end #15-
  
      it "should have the right title" do #16
        post :create, :user => @attr
        response.should have_selector("title", :content =>"Sign up")
      end #16-

      it "it should render the 'new' page" do #17
        post :create, :user => @attr
        response.should render_template('new')
      end #17-
     end #13-
     
     describe "success" do  #18

      before(:each) do #19
        @attr = { :name => "New User", :email => "user@example.com", :password => "foobar", :password_confirmation => "foobar" }
      end #19-

      it "should create a user" do # 20
        lambda do
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

      it "should sign the user in" do  #23
        post :create, :user => @attr
        controller.should be_signed_in
      end #23-

     end #18-
  end #12-
  
  describe "GET 'edit'" do #24

    before(:each) do #25
      @user = Factory(:user)
      test_sign_in(@user)
    end #25-
    
    it "should be successful" do #26
      get :edit, :id => @user
      response.should be_success
    end #26-

    it "should have the right title" do #27
      get :edit, :id => @user
      response.should have_selector("title", :content => "Edit user")
    end # 27-

    it "should have a link to change the Gravatar" do #28
      get :edit, :id => @user
      gravatar_url = "http://gravatar.com/emails"
      response.should have_selector("a",
                                    :href => gravatar_url,
                                    :content => "change")
    end #28
  end #24

  describe "PUT 'update'" do # 29

    before(:each) do # 30
      @user = Factory(:user)
      test_sign_in(@user)
    end # 30-
    
    describe "failure" do # 31
    
      before(:each) do # 32
        @attr = { :email => "", :name => "", :password => "", :password_confirmation => ""}
      end #32-

      it "should render the 'edit' page" do #33
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end #33-

      it "should have the right title" do #34
        put :update, :id => @user, :user => @attr
        response.should have_selector("title", :content => "Edit user")
      end #34-
    end # 31-

    describe "success" do # 35

      before(:each) do # 36
        @attr = { :name => "New Name", :email => "user@example.org", :password => "barbaz", :password_confirmation => "barbaz"}
      end #36-
      
      it "should change the user's attributes" do #37
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.name.should == @attr[:name]
        @user.email.should == @attr[:email]
      end #37-

      it "should redirect to the user show page" do #38
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end #38-

      it "should have a flash message" do #39
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /updated/
      end # 39-
    end # 35-
  end # 29-

  describe "authentication of edit/update pages" do #40

    before(:each) do # 41
      @user = Factory(:user)
    end # 41-

    describe "for non-signed-in user" do #42

      it "should deny access to 'edit'" do # 43
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end #43 -

      it "should deny access to 'update'" do #44
        put :update, :id => @user, :user => {}
        response.should redirect_to(signin_path)
      end # 44-
    end #42-

    describe "for signed-in users" do #45

      before(:each) do #46
        wrong_user = Factory(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end #46-

      it "should require matching users for 'edit'" do #47
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end #47-

      it "should require matching users for 'update'" do # 48
        put :update, :id => @user, :user => {}
        response.should redirect_to(root_path)
      end #48-
    end #45-
  end #40-    

  describe "GET 'index'" do #46
    
    describe "for non-signed-in users" do #47
      it "should deny access" do #48
        get :index
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end #48 -
    end #47-

    describe "for signed-in users" do #49

      before(:each) do #50
        @user = test_sign_in(Factory(:user))
        second = Factory(:user, :name => "Bobbob", :email => "another@example.com")
        third = Factory(:user, :name => "Benben", :email => "another@example.net")
        @users = [@user, second, third]
        30.times do #55
          @users << Factory(:user, :email => Factory.next(:email))
        end
      end #50-

      it "should be successful" do #51
        get :index
        response.should be_success
      end # 51

      it "should have the right title" do #52
        get :index
        response.should have_selector("title", :content => "All users")
      end #52-

      it "should have an element for each user" do # 53
        get :index
        @users[0..2].each do |user| #54
          response.should have_selector("li", :content => user.name)
        end # 54-
      end #53-

      it "should paginate users" do # 56
        get :index
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/users?page=2", :content => "2")
        response.should have_selector("a", :href => "/users?page=2", :content => "Next")
      end #56
    end #47-
    
   describe "admin attribute" do #57

      before(:each) do 
    ##    @user = test_sign_in(Factory(:user))
           second = Factory(:user, :name => "Bobbob", :email => "another@example.com")
          @attr = { :name => "New User1", :email => "nonadmin@example.com", :password => "foobar", :password_confirmation => "foobar" }
  #      @user = test_sign_in(Factory(:user,  :name => "Bobbob", :email => "another@example.com"))
         @user = User.create!(@attr)
       end #57
   
      it "should respond to admin" do #58
        @user.should respond_to(:admin)
      end

      it "should not be admin by default" do #59
        @user.should_not be_admin
      end

      it "should be convertible to an admin" do #60
        @user.toggle!(:admin)
        @user.should be_admin
      end # 60-
     end #57-
  end #46-
  
  describe "DELETE 'destroy'" do #61

    before(:each) do #62
      @user = Factory(:user)
    end
    
    describe "as a non-signed in user" do #63
      it "should deny access" do #64
        delete :destroy, :id => @user
        response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do #65
      it "should protect the page" do #66
        test_sign_in(@user)
        delete :destroy, :id =>@user
        response.should redirect_to(root_path)
      end
    end

    describe "as a admin user" do #67
      
    before(:each) do #68
      admin = Factory(:user, :email => "admin@example.com", :admin => true)
      test_sign_in(admin)
    end

      it "should destroy the user" do #68
        lambda do #69
        delete :destroy, :id =>@user
        end.should change(User, :count).by(-1)
      end
      
      it "should redirect to the user's page" do #70
        delete :destroy, :id =>@user
        response.should redirect_to(users_path)
      end
     end #67-
   end #61-
end #1-
