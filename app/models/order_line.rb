class OrderLine < ApplicationRecord
  belongs_to :order
  belongs_to :variant
  belongs_to :product

  validates :title, presence: true
  validates :price, presence: true
end
