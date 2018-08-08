class VariantsQuery < QueryObject
  add_range_attributes :updated_at, :created_at

  def initialize params={}, relation = Variant.all
    super(params, relation)
  end
end
