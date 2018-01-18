class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :account_id, null: false
      t.string :email, null:false
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :suffix
      t.string :title
      t.string :password_digest, null: false
      t.integer :user_type
      t.integer :user_status, default: 0
      t.string :token

      t.integer :status, default: 0
      t.timestamps
    end
    add_index :users, :account_id
    add_index :users, [:account_id, :email], unique: true
    add_index :users, :token, unique: true
  end
end
