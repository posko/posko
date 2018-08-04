class ProductsQuery
  def initialize(params = {}, rel)
    @relation = rel
    @params = params
  end

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

  private

  attr_reader :params, :relation

  def by_ids
    relation.where(id: params[:ids])
  end

  def paginate
    relation.page(page).per(limit)
  end

  def since_id
    relation.where("products.id < ?", params[:since_id])
  end

  def page
    params[:page] || 1
  end

  def attribute_min key
    # Calm down. attribute_name is whitelisted. check #all method
    column_name = key.to_s.gsub(/_min$/, "")
    relation.where("products.#{column_name} >= ?", params[key.to_sym])
  end

  def attribute_max key
    # Calm down. attribute_name is whitelisted. check #all method
    column_name = key.to_s.gsub(/_max$/, "")
    relation.where("products.#{column_name} <= ?", params[key.to_sym])
  end

  def method_missing m
    if m[/_max$/]
      send "attribute_max", m
    elsif m[/_min$/]
      send"attribute_min", m
    else
      raise NoMethodError
    end
  end

  def limit
    @limit ||= get_limit
  end

  def get_limit
    params[:limit] || 50
    # lim > 100 ? 100 : lim.to_i
  end

end
