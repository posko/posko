class Api::V1::ApiController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  helper_method :current_user, :current_account

  private
  def current_user
    @current_user ||= @current_access_token.user
  end

  def current_account
    @current_account ||= current_user.account
  end

  def authenticate_user
    authenticate_or_request_with_http_basic do |token, auth_token|
      @current_access_token = AccessKey.find_by_token token
      if @current_access_token.auth_token == auth_token
        @current_user = @current_access_token.user
      end
    end
  end
end
