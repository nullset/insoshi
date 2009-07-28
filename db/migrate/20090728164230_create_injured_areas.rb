class CreateInjuredAreas < ActiveRecord::Migration
  def self.up
    create_table :injured_areas, :force => true do |t|
      t.string :name
      t.integer :parent_id
      t.timestamps
    end
    
    spine = InjuredArea.create(:name => "Spine")
    ["Cervical Spine", "Thoracic Spine", "Lumbar Spine"].each do |i|
      InjuredArea.create(:name => i, :parent_id => spine.id)
    end
    
    joint = InjuredArea.create(:name => "Joint Replacement")
    ["Hip", "Knee", "Shoulder", "Ankle", "Other"].each do |j|
      InjuredArea.create(:name => j, :parent_id => joint.id)
    end
    
    sports = InjuredArea.create(:name => "Sports Medicine")
    ["Hip", "Knee", "Shoulder", "Other"].each do |s|
      InjuredArea.create(:name => s, :parent_id => sports.id)
    end
    
    other = InjuredArea.create(:name => "Other")
    InjuredArea.create(:name => "Foot and Ankle", :parent_id => other.id)
    InjuredArea.create(:name => "Hand, Wrist, and Elbow", :parent_id => other.id)
    
  end

  def self.down
    drop_table :injured_areas
  end
end
