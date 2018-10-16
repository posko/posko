class ProductForm < FormObject
  attr_accessor :account, :title, :sku, :price, :cost, :barcode,
    :compare_at_price, :created_by, :vendor

  validates :title, presence: true
  validates :price, presence: true

  def save
    if valid? && service_object.perform
      self
    else
      false
    end
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
