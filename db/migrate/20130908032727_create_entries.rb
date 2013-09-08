class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :type
      t.integer :category_id
      t.integer :household_id
      t.integer :user_id
      t.text :description
      t.float :amount
      t.date :incurred_on

      t.timestamps
    end

    add_index :entries, :type
    add_index :entries, :category_id
    add_index :entries, :household_id
    add_index :entries, :user_id
    add_index :entries, :incurred_on
  end
end
