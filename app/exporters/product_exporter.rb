require 'csv'

class ProductExporter < ExporterObject
  attr_reader :records

  def initialize(options = {})
    @records = options.fetch(:records)
  end

  def perform
    csv
  end

  def csv
    @csv ||= generate_csv
  end

  def headers
    ['Handle', 'SKU', 'Name', 'Cost', 'Price', 'Barcode']
  end

  private

  # rubocop:disable Metrics/MethodLength
  def generate_csv
    CSV.generate do |csv|
      csv << headers
      variants.each do |variant|
        csv << [
          variant.product.handle,
          variant.sku,
          variant.product.title,
          variant.cost,
          variant.price,
          variant.barcode
        ]
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  def variants
    @variants ||= Variant.where(product: records).includes(:product)
                         .references(:product)
  end
end
