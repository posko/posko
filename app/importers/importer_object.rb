class ImporterObject
  def valid?
    true
  end

  def errors
    @errors ||= ActiveModel::Errors.new(self)
  end
end
