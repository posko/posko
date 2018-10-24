require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/prawn_outputter'

class BarcodesPdf < PdfObject
  attr_reader :variants
  def setup(*args)
    @variants = args[0][0].fetch(:variants)
    draw_product_barcode
  end

  def page_setup
    {
      page_size: [8.5.in, 11.in],
      page_layout: :portrait
    }
  end

  def draw_product_barcode
    variants.each_with_index do |variant, i|
      x = compute_for_x i
      y = compute_for_y i
      draw_barcode variant, [x, y]
    end
  end

  def compute_for_x(index)
    (2.in * (index % 3).floor) + 0.2.in * (index % 3).floor
  end

  def compute_for_y(index)
    10.in - (1 * index / 3).in
  end

  def draw_barcode(variant, position, options = {})
    options = { width: 2.in, height: 1.in }.merge(options)
    bounding_box position, options do
      stroke_bounds
      draw_barcode_text variant
      generate_barcode(self, variant.barcode)
      draw_text variant.barcode, at: [0.2.in, 0.1.in]
    end
  end

  def generate_barcode(pdf, barcode)
    b = Barby::Code128.new barcode
    b.annotate_pdf(pdf, height: 0.25.in, y: 0.30.in, x: 0.2.in)
  end

  def draw_barcode_text(variant)
    draw_text variant.title.first(20), at: [0.2.in, 0.75.in]
  end
end
