class Shift < ApplicationRecord
  belongs_to :user

  has_many :shift_activities, dependent: :destroy
  has_many :invoices, dependent: :nullify

  validates :starting_cash, presence: true
end
