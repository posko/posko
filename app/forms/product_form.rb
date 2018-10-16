class ProductForm < FormObject
  attr_accessor :title, :sku, :price, :cost, :barcode, :compare_at_price,
    :created_by, :vendor, :product
  attr_reader :account

  delegate :persisted?, to: :product

  validates :title, presence: true
  validates :price, presence: true

  def initialize(options = {})
    @product = options.fetch(:product) { Product.new }
    super(options)
  end

  def persist!
    service_object.perform
  end

  def service_object
    @service_object ||= ProductCreationService.new(
      created_by: created_by,
      account: created_by.account,
      title: title,
      sku: sku,
      price: price,
      cost: cost,
      barcode: barcode,
      compare_at_price: compare_at_price
    )
  end
end
