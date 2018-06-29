class Variant < ApplicationRecord
  enum variant_type: [:regular, :composite, :component]
  has_many :invoice_lines
  has_many :product_components
  has_many :child_product_components, foreign_key: "parent_variant_id", class_name: "ProductComponent"

  belongs_to :product
  belongs_to :parent_product, foreign_key: "parent_product_id", class_name: "Product", optional: true
  belongs_to :parent_variant, foreign_key: "parent_variant_id", class_name: "Variant", optional: true

  validates :title, presence: true
  validates :price, presence: true
end
