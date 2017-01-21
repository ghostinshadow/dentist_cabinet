class CreatePatientPictures < ActiveRecord::Migration[5.0]
  def change
    create_table :patient_pictures do |t|
      t.integer :patient_id
      t.string :picture

      t.timestamps
    end
  end
end
