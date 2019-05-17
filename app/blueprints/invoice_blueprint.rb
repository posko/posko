class InvoiceBlueprint < Blueprinter::Base
  identifier :id
  fields :account_id, :customer_id, :user_id

  fields :invoice_number

  fields :total_line_items_price, :total_discounts, :subtotal, :total_price,
    :total_tax, :total_weight

  fields :first_name, :middle_name, :last_name, :email, :contact_number, :suffix

  fields :fulfillment_status, :note
  fields :invoice_status, :status

  view :destroyed do
    fields :deleted
  end
end
