class Api::V1::OrderLinesController < Api::V1::ApiController
  before_action :authenticate_user
  def index
    @order_lines = order.order_lines
    render json: { order_lines: @order_lines }
  end

  def create
    @order_line = order.order_lines.new order_line_params
    if @order_line.save
      render status: :ok, json: { order_line: @order_line, order: @order }
    else
      render status: :unprocessable_entity, json: { messages: @order_line.errors.full_messages }
    end
  end

  def show
    @order_line = OrderLine.find_by id: params[:id]
    if @order_line
      render json: { order_line: @order_line }
    else
      render status: :not_found, json: { messages: ["Order not found"] }
    end
  end

  private

  def order_line_params
    params.require(:order_line).permit(:variant_id, :product_id, :title, :price)
  end

  def order
    @order ||= current_account.orders.find(params[:order_id])
  end
end
