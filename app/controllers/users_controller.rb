class UsersController < ApplicationController
  before_action :find_user, except: [:index, :new, :create]
  def index
    @users = current_account.users
    respond_to do |format|
      format.html
      format.json do
        render json: UserDatatable.new(view_context, {
          current_account: current_account
        })
      end
    end
  end

  def new
    @user = current_account.users.new
  end

  def create
    @user = current_account.users.new user_params
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

    def find_user
      @user ||= current_account.users.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
