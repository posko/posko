class CustomersController < ApplicationController
  before_action :find_customer, except: [:index, :new, :create]
  def index
    @customers = current_account.customers
  end

  def new
    @customer = current_account.customers.new
  end

  def create
    @customer = current_account.customers.new customer_params
    if @customer.save
      redirect_to customers_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @customer.update_attributes(customer_params)
      redirect_to customers_path
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @customer.destroy
    redirect_to customers_path
  end

  private

  def find_customer
    @customer ||= current_account.customers.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email)
  end
end
