class ComponentBlueprint < Blueprinter::Base
  identifier :id

  fields :variant_id
  fields :quantity, :cost

  fields :component_type, :component_status, :status
  fields :created_at, :updated_at
end
