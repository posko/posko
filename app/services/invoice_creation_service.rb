class InvoiceCreationService < ServiceObject
  attr_reader :invoice, :invoice_lines, :user, :customer
  def initialize(options={})
    @invoice_number         = options.fetch(:invoice_number)
    @invoice_lines_params   = options.fetch(:invoice_lines)
    @user                   = options[:user]
    @customer               = options[:customer]
    @total_amount           = 0
  end

  def account
    @account ||= user.account
  end

  def valid?
    true
  end

  protected

    attr_accessor :total_amount

  private

  attr_reader :customer_id, :invoice_number, :invoice_params, :invoice_lines_params

  def perform_service
    return false unless valid?
    ActiveRecord::Base.transaction do
      build_invoice
      build_invoice_lines
      recompute_invoice
      invoice.save!
    end
  rescue ActiveRecord::RecordInvalid => exception
    @errors =  exception.model.errors.full_messages.last
    return false
  end

  def build_invoice
      @invoice = account.invoices.build(
        invoice_number: invoice_number,
        customer: customer,
        invoice_status: "fulfilled",
        user: user
      )
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
end
