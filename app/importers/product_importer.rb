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
    product = account.products.find_by(handle: row['Handle'])
    if product
      product.update!(product_attributes(row))
    else
      account.products.create!(product_attributes(row))
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
          title: row['Name'],
          price: row['Price'],
          cost: row['Cost'],
          barcode: row['Barcode']
        }
      ]
    }
  end
  # rubocop:enable Metrics/MethodLength
end
