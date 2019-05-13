class VariantsController < ApplicationController
  def index
    @variants = product.variants
    render json: blueprint(@variants)
  end

  def create
    @variant = product.variants.new variant_params
    if variant.save
      render json: blueprint(variant)
    else
      render_record_invalid(variant)
    end
  end

  def update
    if variant.update variant_params
      render json: blueprint(variant)
    else
      render_record_invalid(variant)
    end
  end

  def show
    render json: blueprint(variant)
  end

  def destroy
    variant.destroy
    render json: blueprint(variant)
  end

  private

  def variant
    @variant ||= current_account.variants.find(params[:id])
  end

  def variant_params
    params.require(:variant).permit(:price, :sku, :variant_type,
      option_value_ids: [])
  end

  def product
    @product ||= current_account.products.find(params[:product_id])
  end
end
