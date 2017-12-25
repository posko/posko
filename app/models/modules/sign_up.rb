class SignUp < ActiveRecordLike
  # Add more attributes if you'd like to
  attribute :account_name, String
  attribute :company, String
  attribute :email, String
  attribute :password, String

  validates_presence_of :account_name, :email, :password, :company
	validates :account_name, format: { without: /\s/ }
  validates :email, format: /@/
  validates :password, length: {minimum: 4}
  def process
    if valid?
      sign_up!
      @processed = true
    else
      false
    end
  end
  def user
    @user ||= account.users.find_by_email(email)
  end
  def account
    if processed?
      @account
    else
      raise "Account is still empty. Ensure success of 'process' method first."
    end
  end
  def processed?
    @processed
  end
  private
    def sign_up!
      Account.transaction do
        create_account!
        create_user!
      end
    end
    def create_account!
      @account = Account.create!(name: account_name, company: company)
    end
    def create_user!
      # add roles if implemeted
      @user = @account.users.create!(email: email, password: password)
    end
end
