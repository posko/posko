class ApplicationController < ActionController::API
  before_action :check_session
  before_action :set_raven_context
  helper_method :current_user, :current_account

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_account
    @current_account ||= current_user.account
  end

  private

  def check_session
    render status: :unauthorized, json: { message: 'Unauthorized '} unless current_user
  end

  def set_raven_context
    Raven.user_context(id: session[:user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

  def render_unauthorized
    render status: :unauthorized, json: { message: 'Unauthorized '}
  end
end
