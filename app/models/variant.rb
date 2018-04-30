class Variant < ApplicationRecord
  enum variant_type: [:regular, :composite, :component]
  has_many :order_lines
  has_many :component_products, foreign_key: "parent_variant_id", class_name: "Variant"

  belongs_to :product
  belongs_to :parent_product, foreign_key: "parent_product_id", class_name: "Product", optional: true
  belongs_to :parent_variant, foreign_key: "parent_variant_id", class_name: "Variant", optional: true

  validates :title, presence: true
  validates :price, presence: true
end
