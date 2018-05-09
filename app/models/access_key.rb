class AccessKey < ApplicationRecord
  has_secure_token :token
  has_secure_token :auth_token
  validates_uniqueness_of :token
  belongs_to :user
end
