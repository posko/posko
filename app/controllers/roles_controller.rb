class RolesController < ApplicationController
  def index
    @roles = current_account.roles
  end

  def new
    @role = current_account.roles.new
  end

  def create
    @role = current_account.roles.new role_params
    if @role.save
      redirect_to roles_path
    else
      render 'new'
    end
  end

  def edit
    @role = current_account.roles.find(params[:id])
  end

  def update
    @role = current_account.roles.find(params[:id])
    if @role.update role_params
      redirect_to roles_path
    else
      render 'edit'
    end
  end

  def show
    @role = current_account.roles.find(params[:id])
  end

  def destroy
    @role = current_account.roles.find(params[:id])
    @role.deleted_status!
    redirect_to roles_path
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end
end
