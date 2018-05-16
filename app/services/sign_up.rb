class SignUp < ActiveRecordLike
  # Add more attributes if you'd like to
  attribute :account_name, String
  attribute :company, String
  attribute :email, String
  attribute :password, String
  attribute :first_name, String
  attribute :last_name, String

  validates_presence_of :account_name, :email, :password, :company
  validates :account_name, format: { without: /\s/ }
  validates :email, format: /@/
  validates :password, length: { minimum: 4 }
  def process
    if valid?
      @processed = true
      persist!
    else
      false
    end
  end

  def user
    @user ||= account.users.find_by_email(email)
  end

  def account
    @account
  end

  def processed?
    @processed
  end

  private

  def persist!
    ActiveRecord::Base.transaction do
      create_account!
      create_user!
      return true
    end
  rescue ValidationError
    append_errors account if account
    append_errors user if account and user
    return false
  end

  def create_account!
    @account = Account.new(name: account_name, company: company)
    raise ValidationError unless @account.save
  end

  def create_user!
    # add roles if implemeted
    @user = account.users.new(email: email, password: password, first_name: first_name, last_name: last_name)
    raise ValidationError unless @user.save
  end
end
