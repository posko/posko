class Api::V1::ProductsController < Api::V1::ApiController
  before_action :authenticate_user
  def index
    @products = current_account.products
    if params[:ids].present?
      @products = @products.where(id: params[:ids])
    end

    if params[:page].present? and params[:limit].present?
      @products = @products.page(params[:page]).per(params[:limit])
    end

    if params[:since_id].present?
      @products = @products.where("products.id > ?",  params[:since_id])
    end

    if params[:created_at_min].present?
      @products = @products.where("products.created_at >= ?",  params[:created_at_min])
    end

    if params[:created_at_max].present?
      @products = @products.where("products.created_at <= ?",  params[:created_at_max])
    end

    render json: { products: @products }
  end

  def show
    @product = current_account.products.find_by id: params[:id]
    if @product
      render json: { product: @product }
    else
      render status: :not_found, json: { messages: ["Variant not found"] }
    end
  end

  private

  def product_params
    params.require(:product).permit(:first_name, :last_name, :email)
  end
end
