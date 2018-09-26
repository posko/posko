class Product < ApplicationRecord
  enum product_type: [:regular, :composite, :component]

  attr_accessor :price

  has_many :variants, dependent: :destroy
  has_many :invoice_lines, dependent: :destroy
  has_many :components, through: :variants
  belongs_to :account
  belongs_to :created_by, class_name: 'User'

  accepts_nested_attributes_for :variants

  validates :title, presence: true
  validates :account_id, presence: true
  validates :handle, uniqueness: { scoped: :account }
  validate :default_variant_only, if: :composite?

  before_validation :create_unique_handle, on: :create

  def default_variant_only
    if variants.size > 1
      errors[:base] << 'Composite product should only have 1 variant'
    else
      false
    end
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
