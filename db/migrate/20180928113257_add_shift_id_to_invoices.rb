class AddShiftIdToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :shift_id, :bigint
    add_index :invoices, :shift_id
    add_index :invoices, [:shift_id, :user_id]
  end
end
