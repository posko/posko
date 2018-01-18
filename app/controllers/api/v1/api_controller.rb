class Api::V1::ApiController < ActionController::API

  def current_user
    @current_user ||= User.find_by_token(request.headers["POSKO-Token"])
  end
  def current_account
    @current_account ||= user.account
  end
end
