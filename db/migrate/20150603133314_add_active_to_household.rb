class AddActiveToHousehold < ActiveRecord::Migration
  def change
    add_column :households, :active, :boolean, default: true
  end
end
