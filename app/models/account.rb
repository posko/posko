class Account < ApplicationRecord
  has_many :users
  alias_attribute :account_name, :name
  # has_many :branches
  validates_presence_of :name, :company
  validates :account_name, format: { without: /\s/ }, uniqueness: true
end
