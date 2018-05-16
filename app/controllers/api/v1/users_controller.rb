class Api::V1::UsersController < Api::V1::ApiController
  before_action :authenticate_user
  def index
    @users = current_account.users
    render json: { users: @users }
  end
end
