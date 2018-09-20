class AuthenticationService < ServiceObject
  attr_reader :access_key, :account_name, :email, :password

  def initialize(options = {})
    @account_name = options.fetch(:account_name)
    @email = options.fetch(:email)
    @password = options.fetch(:password)
  end

  def process
    if valid? && authenticate
      self
    else
      add_error 'Incorrect credentials'
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

  def authenticate
    if user.authenticate password
      create_access_key
      true
    else
      false
    end
  end

  def create_access_key
    @access_key = user.access_keys.create
  end

  def valid?
    account && user
  end
end
