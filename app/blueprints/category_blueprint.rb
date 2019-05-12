class CategoryBlueprint < Blueprinter::Base
  identifier :id

  fields :account_id, :parent_id

  fields :name, :depth, :directory

  fields :category_status, :status
  # field :category_type

  view :destroyed do
    fields :deleted
  end
end
