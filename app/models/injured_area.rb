class InjuredArea < ActiveRecord::Base
  has_many :injuries
  has_many :people, :through => :injuries
  acts_as_tree :order => "created_at"
  
  def slug
    name.downcase.gsub(/ /, "_")
  end
  
  def parent_slug
    parent.name.downcase.gsub(/ /, "_") + "_#{slug}"
  end
end
