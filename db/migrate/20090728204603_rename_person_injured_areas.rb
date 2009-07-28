class RenamePersonInjuredAreas < ActiveRecord::Migration
  def self.up
    rename_column :people, :injured_areas, :search_injured_areas
  end

  def self.down
    rename_column :people, :search_injured_areas, :injured_areas
  end
end
