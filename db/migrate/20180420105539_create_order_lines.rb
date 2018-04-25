class CreateOrderLines < ActiveRecord::Migration[5.1]
  def change
    create_table :order_lines do |t|
      t.integer   :order_id
      t.integer   :variant_id
      t.integer   :product_id

      t.string    :title
      t.string    :sku
      t.decimal   :price
      t.decimal   :compare_at_price
      t.string    :barcode

      t.integer   :order_line_status, default: 0
      t.integer   :status, default: 0
      t.timestamps
    end
  end
end
