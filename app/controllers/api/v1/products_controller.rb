class Api::V1::ProductsController < Api::V1::ApiController
  before_action :authenticate_user
  def index
    @products = ProductsQuery.new(params, Product.all).call
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
