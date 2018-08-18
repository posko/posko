class UsersQuery < Queryko::QueryObject
  add_range_attributes :updated_at, :created_at

  def initialize params={}, relation = User.all
    super(params, relation)
  end
end
