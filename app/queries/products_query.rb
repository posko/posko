class ProductsQuery < QueryObject
  def all
    @relation = paginate
    # relation = relation.page(page).per(limit)
    @relation = by_ids if params[:ids]
    @relation = since_id if params[:since_id]
    @relation = created_at_min if params[:created_at_min]
    @relation = created_at_max if params[:created_at_max]
    @relation = id_max if params[:id_max]
    @relation = id_min if params[:id_min]
    return @relation
  end
end
