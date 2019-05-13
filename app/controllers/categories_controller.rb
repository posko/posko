class CategoriesController < ApplicationController
  def index
    @categories = current_account.categories.first_level
    render json: blueprint(@categories)
  end

  def create
    @category = current_account.categories.new category_params
    if category.save
      render json: blueprint(category)
    else
      render_record_invalid(category)
    end
  end

  def update
    if category.update(category_params)
      render json: blueprint(category)
    else
      render_record_invalid(category)
    end
  end

  def show
    render json: blueprint(category)
  end

  def destroy
    category.destroy
    render json: blueprint(category)
  end

  private

  def category
    @category ||= current_account.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:parent_id, :name, :depth, :directory)
  end
end
