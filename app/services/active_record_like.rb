class ActiveRecordLike
  include Virtus.model
  # extend ActiveRecord::Naming
  include ActiveModel::Validations
  include ActiveModel::Conversion
  validate :validate_data

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end
  def persist!
    raise "persist! method Not implemented"
  end

  def persisted?
    false
  end
  def errors_messages
    self.errors.full_messages
  end
  private
    def add_error message
      errors.add(:base, message)
    end

    def append_errors obj
      obj.errors.full_messages.each do |er|
        add_error er
      end
    end
    # prototype
    def validate_data
    end
end
