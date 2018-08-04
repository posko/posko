class QueryObject
  include RangeAttributes

  def initialize(params = {}, rel)
    @relation = rel
    @params = params
  end

  def call
    @relation = all
    @relation = filter_by_range_attributes
    return @relation
  end

  private
  attr_reader :params, :relation

  def filter_by_range_attributes
    self.range_attributes.each do |range_attribute|
      @relation = send("attribute_max", "#{range_attribute}_max") if params["#{range_attribute}_max".to_sym]
      @relation = send("attribute_min", "#{range_attribute}_min") if params["#{range_attribute}_min".to_sym]
    end
    @relation
  end

  def send_max range_attribute
    method_name = range
  end
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

  def since_id
    relation.where("products.id < ?", params[:since_id])
  end

  def attribute_min key
    # Calm down. column_name is whitelisted. check #add_range_attributes method
    column_name = key.to_s.gsub(/_min$/, "")
    relation.where("products.#{column_name} >= ?", params[key.to_sym])
  end

  def attribute_max key
    # Calm down. column_name is whitelisted. check #add_range_attributes method
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
