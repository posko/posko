class OptionTypesController < ApplicationController
  def index
    @option_types = product.option_types
    render json: blueprint(@option_types)
  end

  def create
    @option_type = product.option_types.new option_type_params
    if option_type.save
      render json: blueprint(option_type)
    else
      render_record_invalid(option_type)
    end
  end

  def edit; end

  def update
    if option_type.update(option_type_params)
      render json: blueprint(option_type)
    else
      render_record_invalid(option_type)
    end
  end

  def show
    render json: blueprint(option_type)
  end

  def destroy
    option_type.destroy
    render json: blueprint(option_type)
  end

  private

  def product
    @product ||= current_account.products.find(params[:product_id])
  end

  def option_type
    @option_type ||= current_account.option_types.find(params[:id])
  end

  def option_type_params
    params.require(:option_type).permit(:name)
  end
end
