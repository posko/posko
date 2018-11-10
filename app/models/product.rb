class Product < ApplicationRecord
  enum product_type: [:regular, :composite, :component]
  enum product_status: [:active]
  attr_accessor :price

  has_many :variants, dependent: :destroy
  has_many :invoice_lines, dependent: :destroy
  has_many :components, through: :variants
  has_many :classifications, dependent: :destroy
  has_many :categories, through: :classifications
  has_many :option_types, dependent: :destroy

  belongs_to :default_variant, class_name: 'Variant', optional: true
  belongs_to :account
  belongs_to :created_by, class_name: 'User'

  accepts_nested_attributes_for :variants

  validates :title, presence: true
  validates :account_id, presence: true
  validates :handle, uniqueness: { scoped: :account }
  validate :default_variant_only, if: :composite?

  before_validation :create_unique_handle, on: :create

  delegate :price, :cost, :sku, :barcode, to: :default_variant

  def default_variant_only
    if variants.size > 1
      errors[:base] << 'Composite product should only have 1 variant'
    else
      false
    end
  end

  # TODO: should be defined explicitly
  def default_variant
    variants.first
  end

  def create_unique_handle
    subject = account.products.find_by(handle: title.parameterize)
    self.handle = generate_new_handle subject
  end

  private

  def generate_new_handle(subject)
    if subject
      generate_handle_from(subject)
    else
      title.parameterize
    end
  end

  def generate_handle_from(subject)
    subject.update(handle_count: subject.handle_count += 1)
    "#{title} #{subject.handle_count}".parameterize
  end
end
