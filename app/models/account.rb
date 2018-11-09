class Account < ApplicationRecord
  has_one  :account_setting, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_lines, through: :invoices
  has_many :customers, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_many :variants, through: :products
  has_many :option_types, through: :products
  has_many :option_values, through: :option_types
  has_many :categories, dependent: :destroy

  alias_attribute :account_name, :name
  # has_many :branches
  validates :name, :company, presence: true
  validates :account_name, format: { without: /\s/ }, uniqueness: true
end
