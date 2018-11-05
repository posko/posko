class SubcategoriesController < ApplicationController
  def new
    @subcategory = category.subcategories.new
  end

  def create
    @subcategory = category.subcategories.new category_params
    @subcategory.account = current_account
    if @subcategory.save
      redirect_to categories_path
    else
      render 'new'
    end
  end

  private

  def category
    @category ||= current_account.categories.find(params[:category_id])
  end

  def category_params
    params.require(:category).permit(:parent_id, :name, :depth, :directory)
  end
end
