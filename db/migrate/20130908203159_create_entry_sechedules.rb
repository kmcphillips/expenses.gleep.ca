class CreateEntrySchedules < ActiveRecord::Migration
  def change
    create_table :entry_schedules do |t|
      t.string :name
      t.integer :category_id
      t.integer :household_id
      t.float :amount
      t.date :starts_on
      t.string :frequency
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :entry_schedules, :category_id
    add_index :entry_schedules, :household_id
    add_index :entry_schedules, :active

    add_column :entries, :entry_schedule_id, :integer
    add_index :entries, :entry_schedule_id
  end
end
