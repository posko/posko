class PdfObject < Prawn::Document
  def initialize
    super
    page_setup
  end

  def page_setup; end

end
