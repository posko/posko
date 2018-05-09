class User < ApplicationRecord
  has_secure_password
  has_secure_token :token
  belongs_to :account

  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :orders
  has_many :access_keys
  # has_many :user_branches
  # has_many :branches
  validates_presence_of :email, :first_name, :last_name
  validates :email, format: /@/, uniqueness: true

  # TODO: Move to presetation object
  def name
    fullname = []
    fullname << first_name
    fullname << last_name
    fullname << suffix if suffix
    fullname.join(" ")
  end
end
