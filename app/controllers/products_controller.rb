class ProductsController < ApplicationController
  def index
    @products = current_account.products.active_status

    respond_to do |format|
      format.html
      format.csv do
        exporter = ProductExporter.new(records: @products)
        send_data exporter.csv, filename: 'products.csv'
      end
    end
  end

  def new
    @product = ProductForm.new
  end

  def create
    @product = ProductForm.new product_params.merge(created_by: current_user)

    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
    product = current_account.products.find(params[:id])
    @product = ProductForm.new product: product
  end

  def update
    product = current_account.products.find(params[:id])
    @product = ProductForm.new product: product
    if @product.update product_params
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

  def import
    @importer = ProductImporter.new(
      filepath: params[:file].path,
      user_id: current_user.id,
      account_id: current_account.id
    )

    if @importer.perform
      redirect_to products_path
    else
      render :import
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :price, :cost, :barcode)
  end
end
