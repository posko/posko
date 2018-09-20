class VariantsQuery < Queryko::QueryObject
  add_range_attributes :updated_at, :created_at
  add_searchables :title

  def initialize(params = {}, relation = Variant.all)
    super(params, relation)
  end
end
