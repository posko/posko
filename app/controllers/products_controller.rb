class ProductsController < ApplicationController
  def index
    @products = current_account.products
  end
  def new
    @products = current_account.products.new
  end
  def create
    @product = current_account.products.new product_params.merge(user: current_user)
    if @product.process
      redirect_to products_path
    else
      puts @product.errors.full_messages
      render "new"
    end
  end
  def edit
    @product = current_account.products.find(params[:id])
  end
  def update
    @product = current_account.products.find(params[:id])
    if @product.update_attributes product_params
      redirect_to users_path
    else
      render 'edit'
    end
  end
  def show
    @product = current_account.products.find(params[:id])
  end
  def destroy
    @product = current_account.products.find(params[:id]).deleted_status!
    redirect_to products_path
  end
  private
    def product_params
      params.require(:product).permit(:title, :price, :vendor, :product_type)
    end
end
