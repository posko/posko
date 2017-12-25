class ActiveRecordLike
  include Virtus.model
  # extend ActiveRecord::Naming
  include ActiveModel::Validations
  include ActiveModel::Conversion

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

  def add_error message
    errors.add(:base, message)
  end
end
