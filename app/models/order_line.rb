class OrderLine < ApplicationRecord
  belongs_to :order
  belongs_to :variant
  belongs_to :product

  validates :title, presence: true
  validates :price, presence: true
  after_create :recompute_order

  def recompute_order
    order.recompute_values
  end
end
