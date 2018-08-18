class InvoiceLinesQuery < Queryko::QueryObject
  add_range_attributes :updated_at, :created_at

  def initialize params={}, relation = InvoiceLine.all
    super(params, relation)
  end
end
