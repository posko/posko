class SignIn < ActiveRecordLike
  attribute :account_name, String
  attribute :email, String
  attribute :password, String
  validates_presence_of :account_name, :email, :password
  validate :validate_data
  def process
    if valid?
      authenticate
    else
      false
    end
  end
  def authenticate
    unless user.authenticate password
      add_error "Incorrect credentials"
      return false
    else
      return true
    end
  end
  def user
    @user ||= account.users.find_by_email(email)
  end
  def account
    @account ||= Account.find_by_name(account_name)
  end
  private
    def validate_data
      unless account and user
        add_error "Incorrect credentials"
      end
    end
end
