class VariantBlueprint < Blueprinter::Base
  identifier :id
  fields :product_id, :parent_product_id, :parent_variant_id
  fields :sku, :price, :compare_at_price, :barcode, :selling_policy,
    :cost, :open_price
  field :default

  fields :variant_type, :variant_status, :status

  view :destroyed do
    fields :deleted
  end
end
