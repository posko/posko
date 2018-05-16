class OrdersController < ApplicationController
  before_action :find_order, except: [:index, :new, :create]
  def index
    @orders = current_account.orders
  end

  def new
    @order = current_account.orders.new
  end

  def create
    @order = current_account.orders.new order_params
    @order.user = current_user
    if @order.save
      redirect_to orders_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @order.update_attributes(order_params)
      redirect_to orders_path
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @order.destroy
    redirect_to orders_path
  end

  private

  def find_order
    @order ||= current_account.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:customer_id, :order_number)
  end
end
