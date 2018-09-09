class InvoiceForm < FormObject
  attr_accessor :customer_id, :invoice_number, :invoice_lines, :subtotal, :user

  validates :invoice_number, presence: true
  validates :invoice_number, numericality: true
  validates :invoice_lines, presence: true
  validates :subtotal, presence: true
  validates :user, presence: true
  validates_with SubtotalValidator

  def save
    if valid? and service_object.perform
      return true
    else
      return false
    end
  end

  def service_object
    InvoiceCreationService.new(
      invoice_number: invoice_number,
      invoice_lines: invoice_lines,
      user: user,
      customer: customer
    )
  end

  def customer
    @customer = Customer.find_by(id: customer_id)
  end

end
