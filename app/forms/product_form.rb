class ProductForm < FormObject
  attr_accessor :title, :sku, :price, :cost, :barcode, :compare_at_price,
    :created_by, :product, :open_price
  attr_reader :account

  delegate :persisted?, :id, :title, :created_by, to: :product
  delegate :price, :cost, :barcode, :compare_at_price, :selling_policy,
    :open_price, to: :default_variant

  validates :title, presence: true
  validates :price, presence: true

  def default_variant
    @default_variant ||= product.variants.first || product.variants.new
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, 'Product')
  end

  def initialize(options = {})
    @product = options.fetch(:product) { Product.new }
    assign_attributes options
    super(options)
  end

  def persist!
    service_object.perform
  end

  def update_attributes(options = {})
    assign_attributes options
    Product.transaction do
      product.save! # it saves default_variant also
      default_variant.save!
    end
  end

  def assign_attributes(options = {})
    assign_product options
    assign_default_variant options
  end

  def assign_product(options = {})
    attrs = options.slice(:title, :created_by, :created_by_id)
    product.assign_attributes(attrs)
  end

  def assign_default_variant(options = {})
    attrs = options.slice(:price, :cost, :barcode, :compare_at_price, :open_price,
      :selling_policy)
    default_variant.assign_attributes(attrs)
  end

  def service_object
    @service_object ||= ProductCreationService.new(
      created_by: created_by,
      title: title,
      sku: sku,
      price: price,
      cost: cost,
      barcode: barcode,
      compare_at_price: compare_at_price,
      open_price: open_price,
      selling_policy: selling_policy
    )
  end
end
