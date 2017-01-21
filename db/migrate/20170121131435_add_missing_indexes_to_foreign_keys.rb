class AddMissingIndexesToForeignKeys < ActiveRecord::Migration[5.0]
  def change
  	add_index :patient_pictures, :patient_id
  	add_index :performed_works, :appointment_id
  end
end
