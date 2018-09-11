class AddQtyToInvoiceLines < ActiveRecord::Migration[5.1]
  def change
    add_column :invoice_lines, :quantity, :decimal, default: 1
  end
end
