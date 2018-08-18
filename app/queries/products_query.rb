class ProductsQuery < Queryko::QueryObject
  add_range_attributes :updated_at, :created_at
  add_range_attributes :id
  add_searchables :title

  def initialize params={}, relation = Product.all
    super(params, relation)
  end
end
