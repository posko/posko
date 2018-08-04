class ProductsQuery < QueryObject
  add_range_attributes :created_at
  add_range_attributes :id

  private
  
  def all
    @relation = paginate
    @relation = by_ids if params[:ids]
    @relation = since_id if params[:since_id]
    return @relation
  end
end
