class ComponentsController < ApplicationController
  def index
    @components = variant.components
    render json: blueprint(@components)
  end

  def create
    @component = variant.components.new component_params
    if component.save
      render json: blueprint(component)
    else
      render_record_invalid(component)
    end
  end

  def update
    if component.update(component_params)
      render json: blueprint(component)
    else
      render_record_invalid(component)
    end
  end

  def show
    render json: blueprint(component)
  end

  def destroy
    component.destroy
    render json: blueprint(component)
  end

  private

  def component
    @component ||= current_account.components.find(params[:id])
  end

  def component_params
    params.require(:component).permit(:variant_id, :quantity, :cost)
  end

  def variant
    @variant ||= current_account.variants.find(params[:variant_id])
  end
end
