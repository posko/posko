class Api::V1::InvoicesController < Api::V1::ApiController
  before_action :authenticate_user
  def index
    @invoices = current_account.invoices
    render json: { invoices: @invoices }
  end

  def create
    @invoice = current_account.invoices.new invoice_params
    @invoice.user = current_user
    if @invoice.save
      render json: { invoice: @invoice }
    else
      render status: :unprocessable_entity, json: { messages: @invoice.errors.full_messages }
    end
  end

  def show
    @invoice = current_account.invoices.find_by id: params[:id]
    if @invoice
      render json: { invoice: @invoice }
    else
      render status: :not_found, json: { messages: ["Invoice not found"] }
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:customer_id, :invoice_number)
  end
end
