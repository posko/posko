class Account < ApplicationRecord
  has_many :users
  # has_many :branches
  validates_presence_of :name, :company
  validates :name, format: { without: /\s/ }
end
