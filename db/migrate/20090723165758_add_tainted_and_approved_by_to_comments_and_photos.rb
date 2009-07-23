class AddTaintedAndApprovedByToCommentsAndPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :tainted, :boolean, :default => true
    add_column :photos, :approved_by, :integer
    add_column :comments, :tainted, :boolean, :default => true
    add_column :comments, :approved_by, :integer
  end

  def self.down
    remove_column :comments, :approved_by
    remove_column :comments, :tainted
    remove_column :photos, :approved_by
    remove_column :photos, :tainted
  end
end
