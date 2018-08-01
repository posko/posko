class Api::V1::AuthController < Api::V1::ApiController
  def sign_in
    @sign_in = SignIn.new sign_in_params
    if @sign_in.process
      @user = @sign_in.user
      @access_key = @sign_in.access_key
      render status: :ok
    else
      render status: :unprocessable_entity, json: { messages: @sign_in.errors_messages }
    end
  end

  private

  def sign_in_params
    params.permit(:account_name, :email, :password)
  end
end
