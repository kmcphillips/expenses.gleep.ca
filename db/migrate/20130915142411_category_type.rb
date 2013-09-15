class CategoryType < ActiveRecord::Migration
  def up
    remove_column :categories, :essential
    add_column :categories, :category_type, :string, default: "non-essential"
    add_index :categories, :category_type
  end

  def down
    remove_column :categories, :category_type
    add_column :categories, :essential, :boolean, default: false
    add_index :categories, :essential
  end
end
