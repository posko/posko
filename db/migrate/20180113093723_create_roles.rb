class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.integer :account_id
      t.string :name
      t.string :description
      t.integer :level, default: 5
      t.integer :role_type, default: 0
      t.integer :role_status, default: 0
      t.string  :code

      t.integer :status, default: 0
      t.timestamps
    end
  end
end
