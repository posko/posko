
class ServiceObject
  attr_reader :performed
  def initialize(options = {}); end

  def self.perform(options = {})
    obj = new options
    obj.perform
    obj
  end

  def perform
    @performed = true
    perform_service
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

  def add_error(message)
    errors.push(message)
  end
end
