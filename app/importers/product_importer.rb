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
        account.products.create!(product_attributes(row))
      end
    end
  end

  private

  def account
    @account ||= Account.find(account_id)
  end

  def product_attributes(row = {})
    {
      handle: row['Handle'],
      title: row['Name'],
      created_by_id: user_id
    }
  end
end
