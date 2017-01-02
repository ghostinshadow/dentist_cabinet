class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.integer :dictionary_id
      t.string :title, limit: 100
      t.string :body, limit: 100

      t.timestamps
    end
    add_index :words, :dictionary_id
  end
end
