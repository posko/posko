class InvoiceCreationService < ServiceObject
  attr_reader :invoice, :invoice_lines, :user, :customer
  def initialize(options={})
    @invoice_params = options.fetch(:params)
    @invoice_lines_params = invoice_params.fetch(:invoice_lines)
    @user = options[:user]
    @customer_id = invoice_params[:customer_id]
    find_customer
  end

  def account
    @account ||= user.account
  end

  def valid?
    # return false unless find_customer
    return false unless find_user
    return true
  end

private

  attr_reader :customer_id, :invoice_params, :invoice_lines_params

  def perform_service
    return false unless valid?

    ActiveRecord::Base.transaction do
      create_invoice!
      create_invoice_lines!
    end
  rescue ActiveRecord::RecordInvalid => exception
    add_error exception.message.split(": ").last
    puts exception.inspect
    return false
  end

  def create_invoice!
      @invoice = account.invoices.create!(
        invoice_number: invoice_params[:invoice_number],
        customer: customer,
        invoice_status: "fulfilled",
        user: user)
  end

  def create_invoice_lines!
    @invoice.invoice_lines.create!(invoice_lines_params)
  end

  def find_customer
    @customer = account.customers.find_by(id: customer_id) rescue nil
  end

  def find_user
    user && user.persisted?
  end
end
