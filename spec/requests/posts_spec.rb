require 'spec_helper'

describe "Posts" do

  describe "the homepage" do
    it "should show the most recent posts by date descending" do
      Post.create!(:title => "First post", :content => "This is the first post", :published => true, :published_at => 1.day.ago)
      Post.create!(:title => "Second post", :content => "This is the second post", :published => true, :published_at => Time.now)
      Post.create!(:title => "Third post", :content => "This is the third post")
      visit "/"
      page.should have_content("First post")
      page.should have_content("Second post")
      page.should_not have_content("Third post")
    end
  end

  describe "viewing an individual post" do
    it "should take me to the post via the slug path" do
      Post.create(:title => "A simple title", :content => "For a simple post")
      visit "/posts/a-simple-title"
      page.body.should match("A simple title")
      page.body.should match("For a simple post")
    end
  end

  describe "posts section of admin panel" do
    it "should display a list of the posts" do
      3.times { Factory(:post) }
      visit "/admin/posts"
      page.should have_content("Title of post 1")
      page.should have_content("Title of post 2")
      page.should have_content("Title of post 3")
    end

    it "should have a New Post button" do
      visit "/admin/posts"
      click_link "New Post"
      fill_in "Title", :with => "Make it so"
      fill_in "Content", :with => "Number one"
      check "Published"
      click_button "Save"
      page.current_path.should match("/admin/posts/make-it-so")
      visit admin_posts_path
      page.body.should match("Make it so")
      #save_and_open_page
    end

    it "should allow me to delete a post" do
      Factory(:post, :title => "Going to delete")
      visit admin_posts_path
      page.body.should match("Going to delete")
      Post.find_by_title("Going to delete").delete
      visit admin_posts_path
      page.body.should_not match("Going to delete")
    end
  end

end
