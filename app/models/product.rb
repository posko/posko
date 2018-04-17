class Product < ApplicationRecord
  belongs_to :account

  has_many :variants

  validates :title, presence: true
  validates :account_id, presence: true
  attr_accessor :price
end
