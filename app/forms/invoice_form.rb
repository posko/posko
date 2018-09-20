class InvoiceForm < FormObject
  attr_accessor :invoice_number, :invoice_lines, :subtotal, :user, :customer_id,
                :account
  attr_reader :service_object

  delegate :invoice, to: :service_object

  validates :invoice_number, presence: true
  validates :invoice_number, numericality: true
  validates :invoice_lines, presence: true
  validates :subtotal, presence: true
  validates :user, presence: true
  validates :account, presence: true
  validates_with InvoiceValidator, if: :invoice_lines

  def save
    if valid? && service_object.perform
      true
    else
      false
    end
  end

  def service_object
    @service_object ||= InvoiceCreationService.new(
      account: account,
      invoice_number: invoice_number,
      invoice_lines: invoice_lines,
      subtotal: subtotal,
      user: user,
      customer: customer,
      caller: self
    )
  end

  def customer
    @customer = Customer.find_by(id: customer_id)
  end
end
