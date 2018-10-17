class ServiceObject
  attr_reader :performed
  def initialize(options = {}); end

  def self.perform(options = {})
    obj = new options
    obj.perform
    obj
  end

  def perform
    if valid? && perform_service
      @performed = true
      self
    else
      false
    end
  end

  def performed?
    @performed || false
  end

  def errors
    @errors ||= []
  end

  private

  def perform_service
    raise "'perform_service' method Not implemented"
  end

  def valid?
    true
  end

  def add_error(message)
    errors.push(message)
  end
end
