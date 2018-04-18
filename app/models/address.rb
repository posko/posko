class Address < ApplicationRecord
  belongs_to :customer
  validates :address1, presence: true
end
