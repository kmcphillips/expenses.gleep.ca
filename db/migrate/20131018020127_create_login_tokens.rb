class CreateLoginTokens < ActiveRecord::Migration
  def change
    create_table :login_tokens do |t|
      t.string :token
      t.integer :household_id
      t.integer :user_id
      t.text :description

      t.timestamps
    end

    add_index :login_tokens, :token
    add_index :login_tokens, :household_id
    add_index :login_tokens, :user_id
  end
end
