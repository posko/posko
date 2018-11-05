class CategoriesController < ApplicationController
  before_action :category, except: [:index, :new, :create]
  def index
    @categories = current_account.categories.first_level
    respond_to do |format|
      format.html
    end
  end

  def new
    @category = current_account.categories.new
  end

  def create
    @category = current_account.categories.new category_params
    if @category.save
      redirect_to categories_path
    else
      render 'new'
    end
  end

  # def edit; end
  #
  # def update
  #   if @category.update(category_params)
  #     redirect_to categories_path
  #   else
  #     render 'edit'
  #   end
  # end
  #
  # def show; end
  #
  # def destroy
  #   @category.destroy
  #   redirect_to categories_path
  # end

  private

  def category
    @category ||= current_account.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:parent_id, :name, :depth, :directory)
  end
end
