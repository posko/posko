class ProductsController < ApplicationController
  def index
    @products = current_account.products
  end
  def new
    @product_creator = ProductCreator.new
  end
  def create
    @product_creator = ProductCreator.new product_creator_params
    @product_creator.user = current_user
    @product_creator.account = current_account
    if @product_creator.process
      redirect_to products_path
    else
      puts @product_creator.errors.full_messages
      render "new"
    end
  end
  private
    def product_creator_params
      params.require(:product_creator).permit(:title, :price, :vendor, :product_type)
    end
end
