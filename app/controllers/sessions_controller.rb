class SessionsController < ApplicationController
  skip_before_action :check_session
  layout "base"
  def new
    @sign_in_form = SignInForm.new
  end

  def create
    @sign_in_form = SignInForm.new sign_in_form_params
    if @sign_in_form.save
      session[:user_id] = @sign_in_form.user.id
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

  def sign_in_form_params
    params.require(:sign_in_form).permit(:account_name, :email, :password)
  end
end
