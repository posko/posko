class Variant < ApplicationRecord
  enum variant_type: [:regular, :composite]
  enum selling_policy: [:each, :weight]

  has_many :invoice_lines, dependent: :destroy
  has_many :components, dependent: :destroy
  has_many :option_value_variants, dependent: :destroy
  has_many :option_values, through: :option_value_variants

  belongs_to :product

  validates :price, presence: true

  def option_value_names
    option_values.pluck(:name).join(', ')
  end

  def self.not_default
    where(default: false)
  end

  # search by :barcode and :product.title
  def self.search(term)
    includes(:product).references(:products)
                      .where("lower(products.title) ILIKE :term OR
        lower(variants.barcode) ILIKE :term OR
        lower(variants.sku) ILIKE :term",
                        term: "%#{term}%")
  end
end

# parent_variant_id and parent_product_id are no longer used.
# Components are now maintained by associative relation
# delete it if there's no future use
