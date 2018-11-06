class ProductCreationService < ServiceObject
  attr_reader :title, :sku, :price, :cost, :barcode, :category_ids,
    :compare_at_price, :account, :created_by, :selling_policy, :open_price
  attr_reader :product, :variant

  def initialize(options = {})
    @created_by = options.fetch(:created_by)
    @account = options[:account] || created_by.account
    @title = options.fetch(:title)
    @sku = options.fetch(:sku)
    @price = options.fetch(:price)
    init_optional_params options
  end

  def valid?
    true
  end

  private

  def init_optional_params(options = {})
    @cost = options[:cost]
    @selling_policy = options[:selling_policy]
    @open_price = options[:open_price]
    @barcode = options[:barcode]
    @category_ids = options[:category_ids]
  end

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
    @product = account.products.create!(title: title, created_by: created_by,
                                        category_ids: category_ids)
  end

  def link_variant_to_product
    product.update(default_variant: variant)
  end

  # rubocop:disable Metrics/MethodLength
  def create_variant!
    @variant = product.variants.create!(
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
