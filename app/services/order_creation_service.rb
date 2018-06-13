class OrderCreationService < ServiceObject
  attr_reader :params, :order, :order_lines, :user, :customer
  def initialize(options={})
    @params = options.fetch(:params)
    @order_params = params.fetch(:order)
    @order_lines_params = params.fetch(:order_lines)
    @customer_id = order_params.fetch(:customer_id)
    @user = options.fetch(:user)
  end

  def perform
    if valid?
      perform_actions
      performed!
    else
      false
    end
  end

  def account
    @account ||= user.account
  end

  def valid?
    return false unless find_errors
    return true
  end

private

  attr_reader :customer_id, :order_params, :order_lines_params


  def perform_actions
    create_order
    create_order_lines
  end
  def create_order
    @order = account.orders.create!(order_number: order_params[:order_number], customer: customer, user: user)
  end
  def create_order_lines
    @order.order_lines.create!(order_lines_params)
  end
  def find_errors
    return false unless find_customer
    return true
  end

  def find_customer
    @customer = account.customers.find_by(id: customer_id) rescue nil
  end
end
