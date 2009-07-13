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
  has_many :activities, :foreign_key => "item_id", :dependent => :destroy,
                        :conditions => "item_type = 'Post'"
  attr_accessible nil
  
  # TODO: TEST: Get a list of the n most recent posts
  def self.recent_posts(limit = 3)
    self.find(:all, :order => "created_at desc", :limit => limit)
  end
  
end
