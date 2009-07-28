class InjuredArea < ActiveRecord::Base
  has_many :injuries
  has_many :people, :through => :injuries
  acts_as_tree :order => "name"
end
