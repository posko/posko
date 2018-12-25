module BarcodesHelper
  def options_for_variants
    options_for_select(variant_options, empty: true)
  end
  def variant_options
    current_account.variants.includes(:product).collect do |variant|
      [
        variant.product.title,
        { data:
          {
            barcode: variant.barcode,
            sku: variant.sku
          }
        },
        variant.id
      ]
    end
  end

  def empty_options
    content_tag :option
  end
end
