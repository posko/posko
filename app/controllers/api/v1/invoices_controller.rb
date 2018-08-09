class Api::V1::InvoicesController < Api::V1::ApiController
  before_action :authenticate_user
  def index
    @invoices = InvoicesQuery.new(params, current_account.invoices).call
    render json: { invoices: @invoices }
  end

  def create
    @service = InvoiceCreationService.new(params: invoice_params, user: current_user)
    if @service.valid? and @service.perform

      render json: { invoice: @service.invoice }
    else
      render status: :unprocessable_entity, json: { messages: @service.errors }
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
    params.require(:invoice).permit(:customer_id, :invoice_number,
      invoice_lines: [ :variant_id, :product_id, :price, :title])
  end
end
