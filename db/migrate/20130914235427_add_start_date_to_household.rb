class AddStartDateToHousehold < ActiveRecord::Migration
  def change
    add_column :households, :started_on, :date
  end
end
