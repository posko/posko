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
      x = (2.in * (i%3).floor)
      x += 0.2.in * (i%3).floor
      y = 10.in - (1 * i/3).in
      draw_barcode variant, [x, y]
    end
  end


  def draw_barcode(variant, position, options = { width: 2.in, height: 1.in })
    bounding_box position, options do
      draw_text variant.title.first(20), at: [0.2.in, 0.75.in]
      stroke_bounds
      barcode = Barby::Code128.new variant.barcode
      barcode.annotate_pdf(self, :height => 0.25.in, y: 0.30.in, x: 0.2.in)
      draw_text variant.barcode, at: [0.2.in, 0.1.in]

    end
  end
end
