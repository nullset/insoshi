class Injury < ActiveRecord::Base
  belongs_to :injured_area
  belongs_to :person
end
