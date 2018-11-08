class Api::V1::AuthController < Api::V1::ApiController
  def sign_in
    @sign_in_form = SignInForm.new sign_in_params
    if @sign_in_form.save
      @user = @sign_in_form.user
      @access_key = @sign_in_form.access_key
    else
      render status: :unauthorized, json: {
        messages: @sign_in_form.errors.full_messages
      }
    end
  end

  private

  def sign_in_params
    params.permit(:account_name, :email, :password)
  end
end
