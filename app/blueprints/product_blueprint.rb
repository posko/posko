class ProductBlueprint < Blueprinter::Base
  identifier :id
  fields :title, :vendor, :handle
  fields :handle_count

  fields :product_type, :product_status, :status

  fields :created_at, :updated_at
end
