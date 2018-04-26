class Variant < ApplicationRecord
  belongs_to :product
  has_many :order_lines
  validates :title, presence: true
  validates :price, presence: true

end
