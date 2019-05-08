class ApplicationController < ActionController::API
  before_action :check_session
  before_action :set_raven_context
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

  private

  def set_raven_context
    Raven.user_context(id: session[:user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
