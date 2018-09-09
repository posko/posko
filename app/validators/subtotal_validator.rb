class SubtotalValidator < ActiveModel::Validator
  def validate(record)
    unless has_required_attributes(record) and total_line_amount(record) == record.subtotal
      record.errors.add(:subtotal, "does not match the total invoice line amount")
    end
  end

  def has_required_attributes(record)
    record.invoice_lines && record.subtotal
  end

  def total_line_amount(record)
    record.invoice_lines.sum { |i| i[:price] }
  end
end
