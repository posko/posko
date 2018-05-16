class AccessKey < ApplicationRecord
  has_secure_token :token
  has_secure_token :auth_token
  validates :token, uniqueness: true
  belongs_to :user
end
