class ProductComponent < ApplicationRecord
  belongs_to :variant
  belongs_to :parent_variant, class_name: "Variant"
  before_validation :copy_variant, on: :create
  def copy_variant
    self.title            = parent_variant.title
    self.sku              = parent_variant.sku
    self.price            = parent_variant.price
    self.compare_at_price = parent_variant.compare_at_price
    self.barcode          = parent_variant.compare_at_price
  end
end
