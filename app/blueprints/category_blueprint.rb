class CategoryBlueprint < Blueprinter::Base
  identifier :id

  fields :account_id, :parent_id

  fields :name, :depth, :directory

  fields :category_status, :status
  fields :created_at, :updated_at
end
