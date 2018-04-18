class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.integer :account_id, null: false
      t.string  :first_name
      t.string  :middle_name
      t.string  :last_name
      t.string  :email
      t.string  :suffix
      t.text    :note

      t.integer :customer_type, default: 0
      t.integer :customer_status, default: 0
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
