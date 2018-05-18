class Api::V1::OrdersController < Api::V1::ApiController
  before_action :authenticate_user
  def index
    @orders = current_account.orders
    render json: { orders: @orders }
  end
  def create
    @order = current_account.orders.new order_params
    @order.user = current_user
    if @order.save
      render json: { order: @order }
    else
      render status: :unprocessable_entity, json: { messages: @order.errors.full_messages}
    end
  end

  def show
    @order = current_account.orders.find_by id: params[:id]
    if @order
      render json: { order: @order}
    else
      render status: :not_found, json: { messages: ["Order not found"]}
    end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :order_number)
  end
end
