class CreateUserRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_roles do |t|
      t.integer :role_id
      t.integer :user_id

      t.integer :status, default: 0
      t.timestamps
    end
    add_index :user_roles, :role_id
    add_index :user_roles, :user_id
  end
end
