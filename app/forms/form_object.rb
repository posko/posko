class FormObject
  include ActiveModel::Model

  def save
    if valid? && persist!
      self
    else
      false
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def save!
    save || raise(ActiveRecord::RecordInvalid)
  end

  def update(options = {})
    if valid? && update_attributes(options)
      self
    else
      false
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def update!(options = {})
    update(options) || raise(ActiveRecord::RecordInvalid)
  end

  def persist!
    raise 'persist! method not defined'
  end

  def update_attributes(_options = {})
    raise 'persist! method not defined'
  end
end
