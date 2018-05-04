# Use this, instead of using after filters of Product
# disable after_create first
class ProductCreator < ActiveRecordLike
  attribute :title, String
  attribute :price, Decimal
  attribute :account, Account
  attribute :product_type, String
  attribute :user, User

  validates_presence_of :price, :title, :account, :product_type, :user

  attr_reader :product, :variant

  def process
    if valid?
      Product.transaction do
        create_product!
        create_default_variant!
      end
    else
      false
    end
  end
  private
    def create_product!
      @product = account.products.create!(title: title, product_type: product_type, created_by: user)
    end
    def create_default_variant!
      @variant = product.variants.create!(title: title, price: price, variant_type: product_type)
    end
    # def log_user
    # end
end
