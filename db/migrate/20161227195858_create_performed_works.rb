class CreatePerformedWorks < ActiveRecord::Migration[5.0]
  def change
    create_table :performed_works do |t|
      t.integer :dictionary_id
      t.integer :word_id
      t.integer :appointment_id
      t.decimal :price, precision: 7, scale: 2
      t.text :teeth_nums

      t.timestamps
    end
    add_index :performed_works, :dictionary_id
    add_index :performed_works, :word_id
  end
end
