class AddContactForAdviceToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :contact_for_advice, :boolean, :default => false
  end

  def self.down
    remove_column :people, :contact_for_advice
  end
end
