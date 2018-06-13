class ServiceObject
  attr_reader :performed
  def initialize
    @performed = false
  end
  def self.perform options={}
    obj = self.new options
    obj.perform
    return obj
  end
  def perform
    raise "'perform' method Not implemented"
  end
  def performed?
    @performed || false
  end
  def performed!
    @performed = true
  end
end
