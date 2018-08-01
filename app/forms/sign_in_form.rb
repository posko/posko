class SignInForm < FormObject
  attr_accessor :account_name, :email, :password

  validates :account_name, :email, :password, presence: true

  delegate :user, to: :service_object
  delegate :access_key, to: :service_object

  attr_reader

  def save

    if valid? and service_object.process
      return true
    else
      errors.add(:base, "Incorrect credentials")
      return false
    end
  end

  def service_object
    @service_object ||= begin
      SignIn.new(
        account_name: account_name,
        email: email,
        password: password
      )
    end
  end

  # def user
  #   service_object.user
  # end

  private

end
