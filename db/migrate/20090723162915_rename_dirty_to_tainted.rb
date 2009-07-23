class RenameDirtyToTainted < ActiveRecord::Migration
  def self.up
    rename_column :posts, :dirty, :tainted
  end

  def self.down
    rename_column :posts, :tainted, :dirty
  end
end
