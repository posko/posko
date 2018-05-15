class AccountsController < ApplicationController
  skip_before_action :check_session
  def new
    @sign_up = SignUp.new
  end

  def create
    @sign_up = SignUp.new sign_up_params
    if @sign_up.process
      redirect_to sign_in_path, notice: "Success"
    else
      render 'new'
    end
  end

  private

  def sign_up_params
    params.require(:sign_up).permit(
      :account_name,
      :first_name,
      :last_name,
      :email,
      :company,
      :password )
  end
end
