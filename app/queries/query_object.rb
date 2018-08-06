class QueryObject
  include RangeAttributes
  include Searchables
  @relation = nil
  def initialize(params = {}, rel)
    @relation = rel
    @params = params
    searchables = []
    range_attributes = []
  end

  def call
    pre_filter
    filter
    filter_by_range_attributes
    filter_searchables
    return relation
  end

  private

  attr_reader :params, :relation
  attr_writer :relation

  def config
    @config ||= {
      paginate: true,
      since_id: true,
      ids: true
    }
  end

  def pre_filter
    self.relation = paginate if config[:paginate]
    self.relation = by_ids if config[:ids] && params[:ids]
    self.relation = since_id if config[:since_id] && params[:since_id]
  end

  def filter_searchables
    self.searchables.each do |searchable|
      column = searchable.to_sym
      self.relation = relation.where(column => params[column]) if params[column].present?
    end
  end

  def filter
  end

  def filter_by_range_attributes
    self.range_attributes.each do |range_attribute|
      self.relation = send("attribute_max", "#{range_attribute}_max") if params["#{range_attribute}_max".to_sym]
      self.relation = send("attribute_min", "#{range_attribute}_min") if params["#{range_attribute}_min".to_sym]
    end
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
end
