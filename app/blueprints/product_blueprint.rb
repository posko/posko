class ProductBlueprint < Blueprinter::Base
  identifier :id
  fields :title, :vendor, :handle
  fields :handle_count

  fields :product_type, :product_status, :status

  view :destroyed do
    fields :deleted
  end
end
