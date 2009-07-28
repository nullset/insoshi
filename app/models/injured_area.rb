class InjuredArea < ActiveRecord::Base
  has_many :injuries
  has_many :people, :through => :injuries
  acts_as_tree :order => "created_at"
  
  def slug
    name.gsub(/ /, "_")
  end
end
