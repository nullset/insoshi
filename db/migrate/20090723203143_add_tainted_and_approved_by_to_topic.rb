class AddTaintedAndApprovedByToTopic < ActiveRecord::Migration
  def self.up
    add_column :topics, :tainted, :boolean, :default => true
    add_column :topics, :approved_by, :integer
  end

  def self.down
    remove_column :topics, :approved_by
    remove_column :topics, :tainted
  end
end
