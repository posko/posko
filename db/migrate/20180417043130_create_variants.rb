class CreateVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :variants do |t|
      t.integer   :product_id, null: false
      t.string    :title
      t.string    :sku
      t.decimal   :price
      t.decimal   :compare_at_price
      t.string    :barcode


      t.integer   :variant_status, default: 0
      t.integer   :status, default: 0
      t.timestamps
    end
  end
end
