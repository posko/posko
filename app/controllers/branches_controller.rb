class BranchesController < ApplicationController
  before_action :branch, except: [:index, :new, :create]
  def index
    @branches = current_account.branches
    respond_to do |format|
      format.html
          end
  end

  def new
    @branch = current_account.branches.new
  end

  def create
    @branch = current_account.branches.new branch_params
    if @branch.save
      redirect_to branches_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @branch.update(branch_params)
      redirect_to branches_path
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @branch.destroy
    redirect_to branches_path
  end

  private

  def branch
    @branch ||= current_account.branches.find(params[:id])
  end

  def branch_params
    params.require(:branch).permit()
  end
end
