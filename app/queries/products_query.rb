class ProductsQuery < QueryObject
  add_range_attributes :updated_at, :created_at
  add_range_attributes :id
  
  def initialize params={}, relation = Product.all
    @params = params
    @relation = relation
  end
end
