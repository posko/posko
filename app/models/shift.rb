class Shift < ApplicationRecord
  belongs_to :user

  validates :starting_cash, presence: true
end
