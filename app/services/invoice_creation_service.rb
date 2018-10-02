class InvoiceCreationService < ServiceObject
  attr_reader :invoice, :invoice_lines, :user, :customer, :shift
  def initialize(options = {})
    @invoice_number         = options.fetch(:invoice_number)
    @invoice_lines_params   = options.fetch(:invoice_lines)
    @user                   = options.fetch(:user)
    @account                = options.fetch(:account)
    @customer               = options[:customer]
    @shift                  = options[:shift]
    reset_variables
  end

  def valid?
    true
  end

  protected

  attr_accessor :total_price, :subtotal, :total_weight, :total_tax,
                :total_line_items_price, :total_discounts

  private

  attr_reader :customer_id, :invoice_number, :invoice_params,
              :invoice_lines_params, :account

  def perform_service
    return false unless valid?

    ActiveRecord::Base.transaction do
      build_invoice
      build_invoice_lines
      calculate_invoice
      invoice.save!
    end
  rescue ActiveRecord::RecordInvalid => exception
    @errors = exception.record.errors.full_messages.last
    false
  end

  def reset_variables
    @total_price            = 0
    @subtotal               = 0
    @total_weight           = 0
    @total_tax              = 0
    @total_discounts        = 0
    @total_line_items_price = 0
  end

  def build_invoice
    @invoice = account.invoices.build(
      invoice_number: invoice_number,
      customer: customer,
      invoice_status: 'fulfilled',
      user: user,
      shift: shift
    )
  end

  def build_invoice_lines
    invoice_lines_params.each do |line|
      invoice_line = invoice.invoice_lines.build(line)

      compute_total_line_items_price invoice_line
      compute_weight invoice_line
      compute_discount invoice_line
      compute_tax invoice_line
    end
    @invoice_lines = invoice.invoice_lines
  end

  def compute_total_line_items_price(line)
    self.total_line_items_price += line.price * line.quantity
  end

  def compute_weight(line)
    self.total_weight += line.weight * line.quantity
  end

  # TODO: implement tax lines
  def compute_tax(line); end

  # TODO: implement discount lines
  def compute_discount(line); end

  def compute_subtotal
    self.total_price = self.total_line_items_price - total_discounts
  end

  def compute_total_price
    self.total_price = subtotal # + others if ever
  end

  def calculate_invoice
    compute_subtotal
    compute_total_price

    invoice.total_line_items_price = self.total_line_items_price
    invoice.total_price = total_price
    invoice.total_weight = self.total_weight
  end
end
