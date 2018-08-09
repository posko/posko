class InvoiceCreationService < ServiceObject
  attr_reader :invoice, :invoice_lines, :user, :customer
  def initialize(options={})
    @invoice_params = options.fetch(:params)
    @invoice_lines_params = invoice_params.fetch(:invoice_lines)
    @user = options[:user]
    @customer_id = invoice_params[:customer_id]
    find_customer
    @total_amount = 0
  end

  def account
    @account ||= user.account
  end

  def valid?
    # return false unless find_customer
    return false unless find_user
    return true
  end
protected
  attr_accessor :total_amount
private

  attr_reader :customer_id, :invoice_params, :invoice_lines_params

  def perform_service
    return false unless valid?
    ActiveRecord::Base.transaction do
      build_invoice
      build_invoice_lines
      recompute_invoice
      invoice.save!
    end
  rescue ActiveRecord::RecordInvalid => exception
    add_error exception.message.split(": ").last
    return false
  end

  def build_invoice
      @invoice = account.invoices.build(
        invoice_number: invoice_params[:invoice_number],
        customer: customer,
        invoice_status: "fulfilled",
        user: user)
  end

  def build_invoice_lines
    invoice_lines_params.each do |invoice_line|
      self.invoice.invoice_lines.build(invoice_line)
      self.total_amount += invoice_line[:price].to_f
    end
    @invoice_lines = invoice.invoice_lines
  end

  def recompute_invoice
    self.invoice.total_line_items_price = self.total_amount
  end

  def find_customer
    @customer = account.customers.find_by(id: customer_id) rescue nil
  end

  def find_user
    user && user.persisted?
  end
end
