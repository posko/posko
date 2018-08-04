class QueryObject
  def initialize(params = {}, rel)
    @relation = rel
    @params = params
  end

  private
  attr_reader :params, :relation

  def paginate
    relation.page(page).per(limit)
  end

  def page
    params[:page] || 1
  end

  def limit
    @limit ||= get_limit
  end

  def get_limit
    params[:limit] || 50
    # lim > 100 ? 100 : lim.to_i
  end


  def by_ids
    relation.where(id: params[:ids])
  end

  def paginate
    relation.page(page).per(limit)
  end

  def since_id
    relation.where("products.id < ?", params[:since_id])
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


end
