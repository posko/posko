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

end
