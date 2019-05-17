class CustomersController < ApplicationController
  def index
    @customers = current_account.customers
    render json: blueprint(@customers)
  end

  def create
    @customer = current_account.customers.new customer_params
    if customer.save
      render json: blueprint(customer)
    else
      render_record_invalid(customer)
    end
  end

  def update
    if customer.update(customer_params)
      render json: blueprint(customer)
    else
      render_record_invalid(customer)
    end
  end

  def show
    render json: blueprint(customer)
  end

  def destroy
    customer.destroy
    render json: blueprint(customer)
  end

  private

  def customer
    @customer ||= current_account.customers.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email)
  end
end
