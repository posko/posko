require "prawn/measurement_extensions"
class PdfObject < Prawn::Document
  def initialize(*args)
    super page_setup
    setup(args)
  end

  def page_setup
    {}
  end

  def setup(*args); end
end
