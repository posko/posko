class Product < ApplicationRecord
  enum product_type: [:regular, :composite, :component]

  attr_accessor :price

  has_many :variants
  has_many :order_lines
  has_many :component_products, through: :variants
  belongs_to :account

  validates :title, presence: true
  validates :account_id, presence: true
  validate :default_variant_only, if: :composite?

  def default_variant_only
    if self.variants.size > 1
      self.errors[:base] << 'Composite product should only have 1 variant'
    end
  end
end
