class AccountsController < ApplicationController
  skip_before_action :check_session
  def new
    @registration_form = RegistrationForm.new
  end

  def create
    @registration_form = RegistrationForm.new registration_form_params
    if @registration_form.save
      redirect_to sign_in_path, notice: "Success"
    else
      render 'new'
    end
  end

  private

  def registration_form_params
    params.require(:registration_form).permit(
      :account_name,
      :first_name,
      :last_name,
      :email,
      :company,
      :password
    )
  end
end
