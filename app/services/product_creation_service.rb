class ProductCreationService < ServiceObject
  attr_reader :title, :sku, :price, :cost,
    :compare_at_price, :account, :created_by
  attr_reader :product, :variant

  def initialize(options = {})
    @account = options.fetch(:account)
    @created_by = options.fetch(:created_by)
    @title = options.fetch(:title)
    @sku = options.fetch(:sku)
    @price = options.fetch(:price)
    @cost = options[:cost]
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

  def create_variant!
    product.variants.create!(
      title: title,
      cost: cost,
      price: price,
      compare_at_price: compare_at_price
    )
  end
end
