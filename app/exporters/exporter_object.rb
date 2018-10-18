class ExporterObject
  def self.perform(*args)
    new(*args).perform
  end

  def perform
    raise 'perform method is not implemented'
  end
end
