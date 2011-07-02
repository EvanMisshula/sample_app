require 'spec_helper'

describe PagesController do #1
  render_views
  describe "GET 'home'" do #2
    it "should be successful" do #3
      get 'home'
      response.should be_success
    end #3-

     it "should have the right title" do #4
      get 'home'
      response.should have_selector("title",
                        :content =>
                          "Ruby on Rails Tutorial Sample App | Home")
   end # 4-
  end # 2-
  describe "GET 'contact'" do #5
    it "should be successful" do #6
      get 'contact'
      response.should be_success
    end # 6-
     it "should have the right title" do #7
      get 'contact'
      response.should have_selector("title",
                        :content =>
                          "Ruby on Rails Tutorial Sample App | Contact")
   end # 7-
  end # 5-

  describe "GET 'about'" do #8
    it "should be successful" do #9
      get 'about'
      response.should be_success
    end # 9-
    
    it "should have the right title" do #10
      get 'about'
      response.should have_selector("title",
                        :content =>
                          "Ruby on Rails Tutorial Sample App | About")
   end #10-
  end # 8-
end # 1-
