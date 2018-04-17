class Product < ApplicationRecord
  belongs_to :account

  has_many :variants

  validates :title, presence: true
  validates :account_id, presence: true
  after_create :create_variant
  attr_accessor :price
  def create_variant
    price = self.price ? self.price : 0
    self.variants.create(title: self.title, price: price)
  end
end
