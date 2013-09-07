class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.boolean :income, default: false
      t.boolean :essential, default: false
      t.boolean :active, default: true
      t.integer :household_id

      t.timestamps
    end

    add_index :categories, :name
    add_index :categories, :income
    add_index :categories, :essential
    add_index :categories, :active
    add_index :categories, :household_id
  end
end
