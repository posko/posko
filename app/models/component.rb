class Component < ApplicationRecord
  belongs_to :variant

  validates :quantity, :cost, presence: true, numericality: true
end
