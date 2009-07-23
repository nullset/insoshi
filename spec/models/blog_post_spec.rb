require File.dirname(__FILE__) + '/../spec_helper'

describe BlogPost do
  
  before(:each) do
    @post = blogs(:one).posts.build(:title => "First post!",
                                    :body => "Hey there")
  end
  
  it "should be valid" do
    @post.should be_valid
  end
  
  it "should require a title" do
    post = BlogPost.new
    post.should_not be_valid
    post.errors.on(:title).should_not be_empty
  end
  
  it "should require a body" do
    post = BlogPost.new
    post.should_not be_valid
    post.errors.on(:body).should_not be_empty
  end
  
  it "should have a maximum body length" do
    @post.should have_maximum(:body, BlogPost::MAX_BODY)
  end
    
  describe "post activity associations" do
    
    before(:each) do
      @post.save!
      @activity = Activity.find_by_item_id(@post)
    end
    
    it "should have an activity" do
      @activity.should_not be_nil
    end
    
    it "should add an activity to the poster" do
      @post.blog.person.recent_activity.should contain(@activity)
    end
  end
  
  describe "comment associations" do
    
    before(:each) do
      @post.save
      @comment = @post.comments.unsafe_create(:body => "The body",
                                              :commenter => people(:aaron))
    end
    
    it "should have associated comments" do
      @post.comments.should_not be_empty
    end
    
    it "should add activities to the poster" do
      @post.comments.each do |comment|
        activity = Activity.find_by_item_id(comment)
        @post.blog.person.activities.should contain(activity)
      end
    end
    
    it "should destroy the comments if the post is destroyed" do
      comments = @post.comments
      @post.destroy
      comments.each do |comment|
        comment.should_not exist_in_database
      end
    end
    
    it "should destroy the comments activity if the post is destroyed" do
      comments = @post.comments
      @post.destroy
      comments.each do |comment|
        Activity.find_by_item_id(comment).should be_nil
      end
    end
  end
  
  describe "class methods" do

    it "should have recent_posts" do
      posts = BlogPost.recent_posts
      posts.length.should == 0
    end
    
  end
  
  describe "approval process" do
    
    before(:each) do
      @post.save!
    end
    
    it "should set tainted == true for any new post" do
      @post.tainted.should == true
    end

    it "should set tainted == true for any updated post" do
      @post.tainted = false
      @post.save!
      @post.tainted.should == false
      @post.title = "Updated title"
      @post.save!
      @post.tainted.should == true
    end
    
    it "should ensure that tainted and approved_by cannot be set by mass assignment" do
      @post.update_attributes(:tainted => false, :approved_by => 1)
      @post.tainted.should == true
      @post.approved_by.should == nil
    end
    
    it "should set approved_by == nil for any new post" do
      @post.approved_by.should == nil
    end
    
  end
  
end
