class AddDefaultVariantToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :default_variant_id, :bigint
    add_index :products, :default_variant_id
  end
end
