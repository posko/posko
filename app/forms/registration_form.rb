class RegistrationForm < FormObject
  # Add more attributes if you'd like to
  attr_accessor(
    :account_name,
    :company,
    :email,
    :password,
    :first_name,
    :last_name
  )

  validates_presence_of :account_name, :email, :password, :company
  validates :account_name, format: { without: /\s/ }
  validates :email, format: /@/
  validates :password, length: { minimum: 4 }

  delegate :account, to: :service_object
  delegate :user, to: :service_object
  def save
    if valid? && service_object.perform
      true
    else
      false
    end
  end

  private

  def service_object
    @service_object ||= begin
      RegistrationService.new(
        account_name: account_name,
        company: company,
        email: email,
        password: password,
        first_name: first_name,
        last_name: last_name
      )
    end
  end
end
