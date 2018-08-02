class RegistrationService < ServiceObject
  # Add more attributes if you'd like to
  attr_reader(
    :account_name,
    :company,
    :email,
    :password,
    :first_name,
    :last_name
  )
  attr_reader :account

  def initialize(options={})
    @account_name = options.fetch(:account_name)
    @company = options.fetch(:company)
    @email = options.fetch(:email)
    @password = options.fetch(:password)
    @first_name = options.fetch(:first_name)
    @last_name = options.fetch(:last_name)
  end

  def user
    @user ||= account.users.find_by(email: email)
  end

  private

  def perform_service
    return false unless valid?
    perform_service
  end

  attr_reader :account

  def processed?
    @processed
  end

  private

  def perform_service
    ActiveRecord::Base.transaction do
      create_account!
      create_user!
    end
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

  def valid?
    account && user
  end
end
