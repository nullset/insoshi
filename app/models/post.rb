# == Schema Information
# Schema version: 20080916002106
#
# Table name: posts
#
#  id         :integer(4)      not null, primary key
#  blog_id    :integer(4)      
#  topic_id   :integer(4)      
#  person_id  :integer(4)      
#  title      :string(255)     
#  body       :text            
#  type       :string(255)     
#  created_at :datetime        
#  updated_at :datetime        
#

class Post < ActiveRecord::Base
  include ActivityLogger

  include SetTainted
  before_save :set_tainted
  # named_scope :all, :conditions => "approved_by is not null or approved_by != '' and rejected is not true", :order => "created_at desc"
  named_scope :tainted, :conditions => "tainted is true", :order => "approved_by, created_at desc"

  has_many :activities, :foreign_key => "item_id", :dependent => :destroy,
                        :conditions => "item_type = 'Post'"
  attr_accessible nil
  
  def self.all(current_person = nil, person = nil)
    if current_person != :false && !current_person.blank? && !person.blank?
      if current_person != :false && current_person.admin == true 
        find(:all, :include => :blog, :conditions => "blogs.person_id = #{person.id}", :order => "posts.created_at desc")    
      elsif current_person.id == person.id
        find(:all, :include => :blog, :conditions => "blogs.person_id = #{current_person.id}", :order => "posts.created_at desc")    
      end
    else
      find(:all, :conditions => "approved_by is not null or approved_by != '' and rejected is not true", :order => "created_at desc")
    end
  end
  
  def self.recent_posts(limit = 3)
    self.find(:all, :conditions => "approved_by is not null or approved_by != '' and rejected is not true", :order => "created_at desc", :limit => limit)
  end
  
  def status
    status = "Post pending approval" if tainted
    status = "Post rejected" if rejected
    status
  end

end
