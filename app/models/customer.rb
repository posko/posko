class Customer < ApplicationRecord
  belongs_to :account
  validates :first_name, presence: true
  validates :last_name, presence: true
end
