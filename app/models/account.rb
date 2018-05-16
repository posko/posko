class Account < ApplicationRecord
  has_many :users
  has_many :products
  has_many :orders
  has_many :customers

  has_many :variants, through: :products
  alias_attribute :account_name, :name
  # has_many :branches
  validates :name, :company, presence: true
  validates :account_name, format: { without: /\s/ }, uniqueness: true
end
