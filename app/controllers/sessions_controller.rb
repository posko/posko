class SessionsController < ApplicationController
  skip_before_action :check_session
  layout "base"
  def new
    @sign_in = SignInForm.new
  end

  def create
    @sign_in = SignInForm.new sign_in_params
    if @sign_in.save
      session[:user_id] = @sign_in.user.id
      redirect_to dashboard_path
    else
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sign_in_path
  end

  private

  def sign_in_params
    params.require(:sign_in).permit(:account_name, :email, :password)
  end
end
