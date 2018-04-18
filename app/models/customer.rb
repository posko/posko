class Customer < ApplicationRecord
  belongs_to :account
  belongs_to  :default_address, class_name: "Address", optional: true

  has_many :addresses

  validates :first_name, presence: true
  validates :last_name, presence: true
end
