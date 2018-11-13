require 'csv'
class ProductImporter
  attr_reader :filepath, :account_id, :user_id
  def initialize(options = {})
    @account_id = options.fetch(:account_id)
    @user_id = options.fetch(:user_id)
    @filepath = options.fetch(:filepath)
  end

  def perform
    Product.transaction do
      CSV.foreach(filepath, headers: true) do |row|
        find_or_create_product! row
      end
    end
  end

  private

  def account
    @account ||= Account.find(account_id)
  end

  def find_or_create_product!(row)
    product = find_product(row)
    if product
      attrs = product_attributes(row)
      product.update!(attrs.except(:handle, :variants_attributes))
      product.default_variant.update!(attrs[:variants_attributes].first)
    else
      account.products.create!(product_attributes(row))
    end
  end

  # rubocop:disable Metrics/MethodLength
  def create_product(row)
    ProductCreationService.perform(
      created_by: user,
      title: row['Title'],
      sku: '',
      price: row['Price'],
      cost: row['Cost'],
      barcode: row['Barcode'],
      compare_at_price: 0,
      open_price: false,
      selling_policy: :each
    )
  end
  # rubocop:enable Metrics/MethodLength

  def user
    @user ||= User.find(@user_id)
  end

  def find_product(row)
    if row['Handle']
      account.products.find_by(handle: row['Handle'])
    else
      handle = row['Name'].parameterize
      account.products.find_by(handle: handle)
    end
  end

  # rubocop:disable Metrics/MethodLength
  def product_attributes(row = {})
    {
      handle: row['Handle'],
      title: row['Name'],
      created_by_id: user_id,
      variants_attributes: [
        {
          price: row['Price'],
          cost: row['Cost'],
          barcode: row['Barcode']
        }
      ]
    }
  end
  # rubocop:enable Metrics/MethodLength
end
