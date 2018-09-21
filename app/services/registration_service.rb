class RegistrationService < ServiceObject
  # Add more attributes if you'd like to
  attr_reader(
    :account_name,
    :company,
    :email,
    :password,
    :first_name,
    :last_name,
    :user
  )
  attr_reader :account

  def initialize(options = {})
    @account_name = options.fetch(:account_name)
    @company = options.fetch(:company)
    @email = options.fetch(:email)
    @password = options.fetch(:password)
    @first_name = options.fetch(:first_name)
    @last_name = options.fetch(:last_name)
  end

  private

  def processed?
    @processed
  end

  def perform_service
    ActiveRecord::Base.transaction do
      create_account!
      create_user!
    end
  end

  def create_account!
    @account = Account.create!(name: account_name, company: company)
  end

  def create_user!
    # add roles if implemeted
    @user = account.users.create!(email: email, password: password, first_name: first_name, last_name: last_name)
  end

  def valid?
    account_name && company_name
  end
end
