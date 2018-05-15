class Transaction < ApplicationRecord
  enum transaction_type: [:sale, :refund, :void]
  belongs_to :order
  belongs_to :customer

  validates :amount, presence: true
  validates :transaction_type, presence: true
end
