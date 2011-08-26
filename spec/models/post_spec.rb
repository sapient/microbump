require 'spec_helper'

describe Post do

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should belong_to(:user) }

  it "should respond to the publish and unpublish commands" do
    post = Post.create(:title => "An article", :content => "Some ramblings")
    post.published?.should be_false
    post.published_at.should be_nil
    post.publish!
    post.published?.should be_true
    post.published_at.should_not be_nil
    post.unpublish!
    post.published?.should be_false
    post.published_at.should be_nil
  end

  describe "New post" do
    it "should create a new Post given valid parameters" do
      post = Post.create!(:title => "Test Title", :content => "This is a blog post")
      post.valid?.should be_true
    end

    it "should be created in draft mode by default" do
      post = Post.create(:title => "Test", :content => "This is the first post")
      post.published?.should be_false
    end

    it "should require a title" do
      post = Post.create(:content => "This is the content")
      post.error_on(:title).should include("can't be blank")
      post.valid?.should be_false
      post.title= "This is the title"
      post.valid?.should be_true
    end

    it "should require some content" do
      post = Post.create(:title => "Test title")
      post.error_on(:content).should include("can't be blank")
      post.valid?.should be_false
      post.title = "This is a title"
    end

    it "should not allow duplicate slugs" do
      post1 = Post.create!(:title => "Title 1", :content => "Content 1")
      post2 = Post.create!(:title => "Title 1", :content => "Content 2")
      post1.slug.should_not match(post2.slug)
    end
  end

  describe "Published posts scope method" do
    it "should give a descending list only including published posts" do
      Factory(:post, :title => "First", :published => true, :published_at => Time.now - 1.day)
      Factory(:post, :title => "Second", :published => true, :published_at => Time.now)
      Factory(:post)
      posts = Post.published.order("published_at DESC")
      posts.first.title.should match("Second")
      posts.second.title.should match("First")
      posts.length.should be(2)

    end
  end

  describe "a post being published" do
    it "should set the published date to the current time when draft is set to false" do
      post = Factory(:post)
      post.published_at.should be_nil
      post.publish!
      post.published.should be_true
      post.published_at.should_not be_nil
    end
  end

  describe "post slug" do
    it "should create a slug from the title" do
      post = Post.create!(:title => "Test title", :content => "Test content")
      post.slug.should match("test-title")
    end
  end
end
