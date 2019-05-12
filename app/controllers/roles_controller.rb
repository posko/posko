class RolesController < ApplicationController
  def index
    @roles = current_account.roles
    render json: blueprint(@roles)
  end

  def create
    @role = current_account.roles.new role_params
    if role.save
      render json: blueprint(role)
    else
      render_record_invalid(role)
    end
  end

  def update
    if role.update role_params
      render json: blueprint(role)
    else
      render_record_invalid(role)
    end
  end

  def show
    render json: blueprint(role)
  end

  def destroy
    role.destroy
    render json: blueprint(role)
  end

  private

  def role
    @role ||= current_account.roles.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name)
  end
end
