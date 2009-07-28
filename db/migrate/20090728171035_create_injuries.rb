class CreateInjuries < ActiveRecord::Migration
  def self.up
    create_table :injuries do |t|
      t.integer :injured_area_id
      t.integer :person_id
      t.timestamps
    end
  end

  def self.down
    drop_table :injuries
  end
end
