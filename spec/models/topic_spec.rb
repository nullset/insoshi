require File.dirname(__FILE__) + '/../spec_helper'

describe Topic do
  
  before(:each) do
    @person = people(:quentin)
    @topic = forums(:one).topics.build(:name => "A topic")
    @topic.person = @person
  end

  it "should be valid" do
    @topic.should be_valid
  end
  
  it "should require a name" do
    topic = Topic.new
    topic.should_not be_valid
    topic.errors.on(:name).should_not be_empty
  end

  it "should have a max name length" do
    @topic.should have_maximum(:name, Topic::MAX_NAME)
  end
  
  it "should have many posts" do
    @topic.posts.should be_a_kind_of(Array)
  end
  
  it "should destroy associated posts" do
    @topic.save!
    post = @topic.posts.unsafe_create(:body => "body", :person => @person)
    # See the custom model matcher DestroyAssociated, located in
    # spec/matchers/custom_model_matchers.rb.
    @topic.should destroy_associated(:posts)
  end
  
  it "should belong to a person" do
    quentin = people(:quentin)
    topic = Topic.new
    topic.person = quentin
    topic.person.should == quentin
  end
  
  describe "associations" do
    
    before(:each) do
      @topic.save!
    end

    it "should have an activity" do
      Activity.find_by_item_id(@topic).should_not be_nil
    end
  end
  
  describe "approval process" do
    
    before(:each) do
      @topic.save!
    end
    
    it "should set tainted == true for any new topic" do
      @topic.tainted.should == true
    end

    it "should set tainted == true for any updated topic" do
      @topic.tainted = false
      @topic.save!
      @topic.tainted.should == false
      @topic.name = "Updated title"
      @topic.save!
      @topic.tainted.should == true
    end
    
    it "should ensure that tainted and approved_by cannot be set by mass assignment" do
      @topic.update_attributes(:tainted => false, :approved_by => 1)
      @topic.tainted.should == true
      @topic.approved_by.should == nil
    end
    
    it "should set approved_by == nil for any new topic" do
      @topic.approved_by.should == nil
    end
    
  end
  
end
