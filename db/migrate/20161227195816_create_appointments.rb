class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.date :creation_time
      t.integer :patient_id

      t.timestamps
    end
    add_index :appointments, :patient_id
  end
end
