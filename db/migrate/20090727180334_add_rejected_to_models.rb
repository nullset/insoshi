class AddRejectedToModels < ActiveRecord::Migration
  def self.up
    add_column :posts, :rejected, :boolean, :default => false
    add_column :photos, :rejected, :boolean, :default => false
    add_column :comments, :rejected, :boolean, :default => false
    add_column :topics, :rejected, :boolean, :default => false
  end

  def self.down
    remove_column :topics, :rejected
    remove_column :comments, :rejected
    remove_column :photos, :rejected
    remove_column :posts, :rejected
  end
end
