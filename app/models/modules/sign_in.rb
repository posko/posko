class SignIn < ActiveRecordLike
  attribute :account_name, String
  attribute :email, String
  attribute :password, String

  validates_presence_of :account_name, :email, :password
  def process
    if valid?
      user.authenticate password
    else
      add_error "Incorrect credentials"

    end
  end
  def user
    @user ||= account.users.find_by_email(email)
  end
  def account
    @account ||= Account.find_by_name(account_name)
  end
end
