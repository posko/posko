class UsersController < ApplicationController
  before_action :check_session
  
  def index
    puts current_user.id
    @users = current_account.users
    render json: { users: UsersQuery.new(params, @users).call }
  end

  def create
    @user = current_account.users.new user_params
    if @user.save
      render json:{ user: UserBlueprint.render_as_hash(@user) }
    else
      render_record_invalid(@user)
    end
  end

  def update
    if user.update(user_params)
      render json:{ user: UserBlueprint.render_as_hash(user) }
    else
      render_record_invalid(user)
    end
  end

  def show
    render json:{ user: UserBlueprint.render_as_hash(user) }
  end

  def destroy
    user.destroy
    render json:{ user: UserBlueprint.render_as_hash(user) }
  end

  private

  def user
    @user ||= current_account.users.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
