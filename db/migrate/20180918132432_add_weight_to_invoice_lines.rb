class AddWeightToInvoiceLines < ActiveRecord::Migration[5.1]
  def change
    add_column :invoice_lines, :weight, :decimal, default: 0
  end
end
