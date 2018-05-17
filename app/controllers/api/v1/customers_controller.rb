class Api::V1::CustomersController < Api::V1::ApiController
  before_action :authenticate_user
  def index
    @customers = current_account.customers
    render json: { customers: @customers }
  end
  def create
    @customer = current_account.customers.new customer_params
    if @customer.save
      render json: { customer: @customer }
    else
      render status: :unprocessable_entity, json: { messages: @customer.errors.full_messages}
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email)
  end
end
