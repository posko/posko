class Product < ApplicationRecord
  enum product_type: [:regular, :composite, :component]

  attr_accessor :price

  has_many :variants
  has_many :invoice_lines
  has_many :product_components, through: :variants
  belongs_to :account
  belongs_to :created_by, class_name: "User"

  validates :title, presence: true
  validates :account_id, presence: true
  validate :default_variant_only, if: :composite?

  def default_variant_only
    if variants.size > 1
      errors[:base] << 'Composite product should only have 1 variant'
    else
      false
    end
  end
end
