class ProductCreationService < ServiceObject
  attr_reader :title, :sku, :price, :cost, :barcode,
    :compare_at_price, :account, :created_by, :selling_policy, :open_price
  attr_reader :product, :variant

  def initialize(options = {})
    @created_by = options.fetch(:created_by)
    @account = options[:account] || created_by.account
    @title = options.fetch(:title)
    @sku = options.fetch(:sku)
    @price = options.fetch(:price)
    @cost = options[:cost]
    @selling_policy = options[:selling_policy]
    @open_price = options[:open_price]
    @barcode = options[:barcode]
  end

  def valid?
    true
  end

  private

  def perform_service
    return false unless valid?

    ActiveRecord::Base.transaction do
      create_product!
      create_variant!
    end
  rescue ActiveRecord::RecordInvalid => exception
    @errors = exception.record.errors.full_messages.last
    false
  end

  def create_product!
    @product = account.products.create!(title: title, created_by: created_by)
  end

  # rubocop:disable Metrics/MethodLength
  def create_variant!
    product.variants.create!(
      title: title,
      sku: sku,
      cost: cost,
      price: price,
      barcode: barcode,
      compare_at_price: compare_at_price,
      selling_policy: selling_policy,
      open_price: open_price,
      default: true
    )
  end
  # rubocop:enable Metrics/MethodLength
end
