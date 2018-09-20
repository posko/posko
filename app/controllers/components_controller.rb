class ComponentsController < ApplicationController
  before_action :variant, only: [:new, :create]
  def index
    @components = variant.components
  end

  def new
    @component = @variant.components.new
  end

  def create
    @component = variant.components.new component_params
    if @component.save
      redirect_to variant_components_path(@component.variant_id)
    else
      render 'new'
    end
  end

  def edit
    @component = Component.find(params[:id])
    @variant = @component.variant
  end

  def update
    @component = Component.find(params[:id])
    @variant = @component.variant
    if @component.update component_params
      redirect_to variant_components_path(@component.variant_id)
    else
      render 'edit'
    end
  end

  def show
    @component = Component.find(params[:id])
  end

  def destroy
    @component = Component.find(params[:id])
    @component.deleted_status!
    redirect_to variant_components_path(@component.variant_id)
  end

  private

  def component_params
    params.require(:component).permit(:variant_id, :quantity, :cost)
  end

  def variant
    @variant ||= current_account.variants.find(params[:variant_id])
  end
end
