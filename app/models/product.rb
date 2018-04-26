class Product < ApplicationRecord
  belongs_to :account

  has_many :variants
  has_many :order_lines
  
  validates :title, presence: true
  validates :account_id, presence: true
  attr_accessor :price
end
