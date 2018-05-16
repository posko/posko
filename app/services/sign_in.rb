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
    if user.authenticate password
      true
    else
      add_error "Incorrect credentials"
      false
    end
  end

  def user
    @user ||= account.users.find_by(email: email)
  end

  def account
    @account ||= Account.find_by(name: account_name)
  end

  private

  def validate_data
    add_error "Incorrect credentials" unless account && user
  end
end
