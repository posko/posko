class BarcodesController < ApplicationController
  def index
  end

  def search
    # TODO: Use query/finder object
    @variants = current_account.variants.search(params[:q]).limit(10)
    render json: { results: render_variants_json }
  end

  def print
    @variants = current_account.variants.where(id: params[:ids].split(','))
    puts @variants.count
    respond_to do |format|
      format.html
      format.pdf do
        send_data BarcodesPdf.new(variants: @variants).render,
          filename: 'barcodes.pdf', disposition: :inline
      end
    end
  end

  private

  def render_variants_json
    @variants.collect do |variant|
      {
        id: variant.id,
        title: variant.product.title,
        sku: variant.sku,
        barcode: variant.barcode
      }
    end
  end
end
