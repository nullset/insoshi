class AddPanoramaPatientInfoToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :panorama_patient, :boolean, :default => false
    add_column :people, :injured_areas, :text
  end

  def self.down
    remove_column :people, :injured_areas
    remove_column :people, :panorama_patient
  end
end
