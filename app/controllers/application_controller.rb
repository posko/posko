class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_session
  helper_method :current_user, :current_account
  def current_user
    @current_user ||= begin
                        User.find(session[:user_id])
                      rescue StandardError
                        nil
                      end
  end

  def current_account
    @current_account ||= begin
                           current_user.account
                         rescue StandardError
                           nil
                         end
  end

  def check_session
    redirect_to sign_in_path unless current_user
  end
end
