class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_session
  helper_method :current_user
  def current_user
    @current_user ||= User.find(session[:user_id]) rescue nil
  end
  def current_account
    @current_account ||= current_user.account rescue nil
  end
  def check_session
    redirect_to sign_in_path unless current_user

  end
end
