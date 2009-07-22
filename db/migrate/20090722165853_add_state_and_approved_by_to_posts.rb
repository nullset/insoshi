class AddStateAndApprovedByToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :dirty, :boolean, :default => true
    add_column :posts, :approved_by, :integer
    
    Post.find(:all).each do |post|
      post.dirty = false
      post.approved_by = 1
      post.save
    end
  end

  def self.down
    remove_column :posts, :approved_by
    remove_column :posts, :state
  end
end
