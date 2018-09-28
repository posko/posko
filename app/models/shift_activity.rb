class ShiftActivity < ApplicationRecord
  enum shift_activity_type: [:pay_in, :pay_out]
  belongs_to :shift

  validates :amount, presence: true
end
