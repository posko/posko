class VariantsController < ApplicationController
  before_action :product, only: [:new, :create]
  def index
    @variants = product.variants
  end

  def new
    @variant = @product.variants.new
  end

  def create
    @variant = product.variants.new variant_params
    if @variant.save
      redirect_to @variant.product
    else
      render 'new'
    end
  end

  def edit
    @variant = current_account.variants.find(params[:id])
  end

  def update
    @variant = current_account.variants.find(params[:id])
    if @variant.update variant_params
      redirect_to @variant.product
    else
      render 'edit'
    end
  end

  def show
    @variant = current_account.variants.find(params[:id])
  end

  def destroy
    @variant = current_account.variants.find(params[:id])
    @variant.deleted_status!
    redirect_to @variant.product
  end

  private

  def variant_params
    params.require(:variant).permit(:price, :sku, :variant_type,
      option_value_ids: [])
  end

  def product
    @product ||= current_account.products.find(params[:product_id])
  end
end
