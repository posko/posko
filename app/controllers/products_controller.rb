class ProductsController < ApplicationController
  def index
    @products = current_account.products
  end
  def new
    @product = current_account.products.new
  end
  def create
    @product = current_account.products.new product_params.merge(created_by: current_user)
    if @product.save
      redirect_to products_path
    else
      render "new"
    end
  end
  def edit
    @product = current_account.products.find(params[:id])
  end
  def update
    @product = current_account.products.find(params[:id])
    if @product.update_attributes product_params
      redirect_to products_path
    else
      render 'edit'
    end
  end
  def show
    @product = current_account.products.find(params[:id])
  end
  def destroy
    @product = current_account.products.find(params[:id])
    @product.deleted_status!
    redirect_to products_path
  end
  private
    def product_params
      params.require(:product).permit(:title, :price, :vendor, :product_type)
    end
end
