class InvoiceCreationService < ServiceObject
  attr_reader :params, :invoice, :invoice_lines, :user, :customer
  def initialize(options={})
    @params = options.fetch(:params)
    @invoice_params = params.fetch(:invoice)
    @invoice_lines_params = params.fetch(:invoice_lines)
    @customer_id = invoice_params.fetch(:customer_id)
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

  attr_reader :customer_id, :invoice_params, :invoice_lines_params


  def perform_actions
    create_invoice
    create_invoice_lines
  end
  def create_invoice
    @invoice = account.invoices.create!(invoice_number: invoice_params[:invoice_number], customer: customer, user: user)
  end
  def create_invoice_lines
    @invoice.invoice_lines.create!(invoice_lines_params)
  end
  def find_errors
    return false unless find_customer
    return true
  end

  def find_customer
    @customer = account.customers.find_by(id: customer_id) rescue nil
  end
end
