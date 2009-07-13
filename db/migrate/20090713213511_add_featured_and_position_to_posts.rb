class AddFeaturedAndPositionToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :featured, :boolean, :default => false
    add_column :posts, :position, :integer
  end

  def self.down
    remove_column :posts, :position
    remove_column :posts, :featured
  end
end
