class Order < ApplicationRecord
  has_many :order_lines
  belongs_to :account
  belongs_to :user
  belongs_to :customer

  validates :order_number, presence: true
  validates :total_line_items_price, presence: true
  validates :total_discounts, presence: true
  validates :subtotal, presence: true
  validates :total_price, presence: true
  validates :total_tax, presence: true
  validates :total_weight, presence: true
end
