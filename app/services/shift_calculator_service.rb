class ShiftCalculatorService < ServiceObject
  attr_reader :shift

  def initialize(options = {})
    @shift = options.fetch(:shift)
  end

  def cash
    @cash ||= compute_cash
  end

  def payments
    @payments ||= compute_payments
  end

  def paid_in
    @paid_in ||= compute_paid_in
  end

  def paid_out
    @paid_out ||= compute_paid_out
  end

  def attributes
    {
      cash: cash,
      payments: payments,
      paid_in: paid_in,
      paid_out: paid_out
    }
  end

  private

  def perform_service
    paid_out
    paid_in
    payments
    cash
  end

  def compute_cash
    shift.starting_cash + paid_out + paid_in + payments
  end

  def compute_payments
    shift.invoices.sum(:subtotal)
  end

  def compute_paid_in
    shift.shift_activities.pay_in.sum(:amount)
  end

  def compute_paid_out
    shift.shift_activities.pay_out.sum(:amount)
  end
end
