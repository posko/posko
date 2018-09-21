class Customer < ApplicationRecord
  belongs_to :account
  belongs_to :default_address, class_name: 'Address', optional: true

  has_many :addresses, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :transactions, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
end
