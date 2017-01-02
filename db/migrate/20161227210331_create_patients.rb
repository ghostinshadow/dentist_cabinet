class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.string :last_name, limit: 100
      t.string :first_name, limit: 100
      t.integer :user_id
      t.integer :doctor_id
      t.boolean :milk_teeth
      t.date :birth_day
      t.integer :town_id
      t.string :telephone

      t.timestamps
    end
    add_index :patients, :user_id
    add_index :patients, :doctor_id
    add_index :patients, :town_id
  end
end
