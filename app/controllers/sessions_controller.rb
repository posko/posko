class SessionsController < ApplicationController
  skip_before_action :check_session

  def create
    sign_in_form = SignInForm.new sign_in_params
    if sign_in_form.save
      session[:user_id] = sign_in_form.user.id
      session[:access_token] = sign_in_form.access_key.token
      render json: { user: UserBlueprint.render_as_hash(sign_in_form.user) }
    else
      render status: :unauthorized, json: { message: 'Invalid credentials' }
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { message: 'Successfully signed out' }
  end

  private

  def sign_in_params
    params.permit(:account_name, :email, :password)
  end
end
