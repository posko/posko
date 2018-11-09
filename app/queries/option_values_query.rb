class OptionValuesQuery < Queryko::QueryObject
  add_range_attributes :updated_at, :created_at
  add_range_attributes :id
  add_searchables :name

  def initialize(params = {}, relation = OptionValue.all)
    super(params, relation)
  end
end
