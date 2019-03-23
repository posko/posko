class CategoriesQuery < Queryko::QueryObject
  add_range_attributes :updated_at, :created_at
  add_range_attributes :id
  add_searchables :name
  # table_name 'categories'
  def initialize(params = {}, relation = Category.all)
    super(params, relation)
  end
end
