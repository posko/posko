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

  def persist!
    raise 'persist! method not defined'
  end
end
