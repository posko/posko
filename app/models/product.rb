class Product < ApplicationRecord
  belongs_to :account
  validates :title, presence: true
  validates :account_id, presence: true
end
