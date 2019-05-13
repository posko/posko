class OptionValuesController < ApplicationController
  def index
    @option_values = current_account.option_values
    render json: blueprint(@option_values)
  end

  def create
    @option_value = option_type.option_values.new option_value_params
    if option_value.save
      render json: blueprint(option_value)
    else
      render_record_invalid(option_value)
    end
  end

  def update
    if option_value.update(option_value_params)
      render json: blueprint(option_value)
    else
      render_record_invalid(option_value)
    end
  end

  def show
    render json: blueprint(option_value)
  end

  def destroy
    option_value.destroy
    render json: blueprint(option_value)
  end

  private

  def option_value
    @option_value ||= current_account.option_values.find(params[:id])
  end

  def option_type
    @option_type ||= current_account.option_types.find(params[:option_type_id])
  end

  def option_value_params
    params.require(:option_value).permit(:name)
  end
end
