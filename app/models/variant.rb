class Variant < ApplicationRecord
  enum variant_type: [:regular, :composite]
  enum selling_policy: [:each, :weight]

  has_many :invoice_lines
  has_many :components

  belongs_to :product

  validates :title, presence: true
  validates :price, presence: true
end

# parent_variant_id and parent_product_id are no longer used. Components are now maintained by associative relation
# delete it if there's no future use
