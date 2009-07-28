# == Schema Information
# Schema version: 20080916002106
#
# Table name: topics
#
#  id                :integer(4)      not null, primary key
#  forum_id          :integer(4)      
#  person_id         :integer(4)      
#  name              :string(255)     
#  forum_posts_count :integer(4)      default(0), not null
#  created_at        :datetime        
#  updated_at        :datetime        
#

class Topic < ActiveRecord::Base
  include ActivityLogger
  
  include SetTainted
  before_save :set_tainted
  named_scope :all, :conditions => "approved_by is not null or approved_by != ''", :order => 'created_at desc'
  named_scope :tainted, :conditions => "tainted is true", :order => "approved_by, created_at desc"

  MAX_NAME = 100
  NUM_RECENT = 6
  
  attr_accessible :name
  
  belongs_to :forum, :counter_cache => true
  belongs_to :person
  has_many :posts, :order => :created_at, :dependent => :destroy,
                   :class_name => "ForumPost"
  has_many :activities, :foreign_key => "item_id", :dependent => :destroy,
                        :conditions => "item_type = 'Topic'"
  validates_presence_of :name, :forum, :person
  validates_length_of :name, :maximum => MAX_NAME
  
  after_create :log_activity
  
  def self.find_recent
    find(:all, :order => "created_at DESC", :limit => NUM_RECENT)
  end
  
  private
  
    def log_activity
      add_activities(:item => self, :person => person)
    end
end
