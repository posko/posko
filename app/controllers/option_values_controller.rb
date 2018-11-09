class OptionValuesController < ApplicationController
  before_action :option_value, except: [:index, :new, :create]
  def index
    @option_values = option_type.option_values
    respond_to do |format|
      format.html
    end
  end

  def new
    @option_value = option_type.option_values.new
  end

  def create
    @option_value = option_type.option_values.new option_value_params
    if @option_value.save
      redirect_to @option_value
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @option_value.update(option_value_params)
      redirect_to @option_value
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @option_value.destroy
    redirect_to option_type_option_values_path @option_value
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
