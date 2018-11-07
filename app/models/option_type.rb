class OptionType < ApplicationRecord
  belongs_to :product

  validates :name, presence: true
end
