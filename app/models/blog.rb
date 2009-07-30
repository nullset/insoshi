# == Schema Information
# Schema version: 20080916002106
#
# Table name: blogs
#
#  id         :integer(4)      not null, primary key
#  person_id  :integer(4)      
#  created_at :datetime        
#  updated_at :datetime        
#

class Blog < ActiveRecord::Base
  belongs_to :person
  has_many :posts, :dependent => :destroy,
                   :class_name => "BlogPost"
end
