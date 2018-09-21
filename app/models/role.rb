class Role < ApplicationRecord
  belongs_to :account
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles

  validates :name, presence: true
end
