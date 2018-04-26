class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer   :order_id
      t.integer   :customer_id

      t.decimal   :amount

      t.integer   :transaction_type
      t.integer   :transaction_status, default: 0
      t.integer   :status, default: 0
      t.timestamps
    end
  end
end
