class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.integer     :account_id
      t.integer     :customer_id
      t.integer     :user_id

      t.integer     :invoice_number
      t.string      :note
      t.decimal     :total_line_items_price
      t.decimal     :total_discounts
      t.decimal     :subtotal
      t.decimal     :total_price
      t.decimal     :total_tax
      t.decimal     :total_weight

      # Customer table is only a reference
      t.string      :first_name
      t.string      :middle_name
      t.string      :last_name
      t.string      :email
      t.string      :contact_number
      t.string      :suffix

      t.integer     :fulfillment_status, default: 0
      t.integer     :invoice_status, default: 0
      t.integer     :status, default: 0
      t.timestamps
    end
  end
end
