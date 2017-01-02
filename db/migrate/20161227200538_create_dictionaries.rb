class CreateDictionaries < ActiveRecord::Migration[5.0]
  def change
    create_table :dictionaries do |t|
      t.integer :user_id
      t.string :title, limit: 100
      t.string :resource_type, limit: 100

      t.timestamps
    end
    add_index :dictionaries, :user_id
  end
end
