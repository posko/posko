class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.string :company , null: false
      t.integer :account_status, default: 0
      t.integer :account_type, default: 0
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
