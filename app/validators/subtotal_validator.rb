class SubtotalValidator < ActiveModel::Validator
  def validate(record)
    unless has_required_attributes(record) and total_line_amount(record) == record.subtotal.to_f
      record.errors.add(:subtotal, "does not match the total invoice line amount")
    end
  end

  def has_required_attributes(record)
    record.invoice_lines && record.subtotal
  end

  def total_line_amount(record)

    record.invoice_lines.sum do |i|
      quantity = i[:quantity] ? i[:quantity].to_f : 1
      i[:price].to_f * quantity
    end
  end
end
