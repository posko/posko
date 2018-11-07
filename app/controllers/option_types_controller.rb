class OptionTypesController < ApplicationController
  before_action :option_type, except: [:index, :new, :create]
  def index
    @option_types = product.option_types
    respond_to do |format|
      format.html
    end
  end

  def new
    @option_type = product.option_types.new
  end

  def create
    @option_type = product.option_types.new option_type_params
    if @option_type.save
      redirect_to @option_type
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @option_type.update(option_type_params)
      redirect_to @option_type
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @option_type.destroy
    redirect_to product_option_types_path @option_type.product
  end

  private

  def product
    @product ||= current_account.products.find(params[:product_id])
  end

  def option_type
    @option_type ||= OptionType.find(params[:id])
  end

  def option_type_params
    params.require(:option_type).permit(:name)
  end
end
