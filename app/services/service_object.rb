class ServiceObject
  attr_reader :performed
  def initialize(options = {}); end

  def self.perform(options = {})
    obj = new options
    obj.perform
    obj
  end

  def self.perform!(options = {})
    obj = new options
    obj.perform!
  end

  def perform
    if valid? && perform_service
      @performed = true
      self
    else
      false
    end
  end

  def perform!
    perform || raise(StandardError.new('Failed to perform service', self))
  end

  def performed?
    @performed || false
  end

  def errors
    @errors ||= ActiveModel::Errors.new(self)
  end

  def valid?
    true
  end

  private

  def perform_service
    raise "'perform_service' method Not implemented"
  end

  def perform_validation
    true # Override this method
  end

  def add_error(message)
    errors.add(:base, message)
  end
end
