class CreateProductComponents < ActiveRecord::Migration[5.1]
  def change
    create_table :product_components do |t|
        t.bigint :variant_id
        t.bigint :parent_variant_id
        t.bigint :parent_product_id

        t.string    :title
        t.string    :sku
        t.decimal   :price
        t.decimal   :compare_at_price
        t.string    :barcode

        t.integer :product_component_type, default: 0
        t.integer :status, default: 0
        t.integer :product_component_status, default: 0

        t.timestamps
    end
  end
end
