class AddIncurredUntil < ActiveRecord::Migration
  def change
    add_column :entries, :incurred_until, :date
  end
end
