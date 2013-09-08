class CreateAuthorizedEmails < ActiveRecord::Migration
  def change
    create_table :authorized_emails do |t|
      t.string :email
      t.integer :household_id

      t.timestamps
    end

    add_index :authorized_emails, :email
    add_index :authorized_emails, :household_id
  end
end
