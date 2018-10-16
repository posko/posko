class FormObject
  include ActiveModel::Model

  def save
    if valid? && persist!
      self
    else
      false
    end
  end

  def save!
    save || raise(ActiveResource::ResourceInvalid)
  end

  # rubocop:disable Rails/ActiveRecordAliases
  def update(options = {})
    if valid? && update_attributes(options)
      self
    else
      false
    end
  end
  # rubocop:enable Rails/ActiveRecordAliases

  def update!
    update || raise(ActiveResource::ResourceInvalid)
  end

  def persist!
    raise 'persist! method not defined'
  end
end
