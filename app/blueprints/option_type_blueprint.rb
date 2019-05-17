class OptionTypeBlueprint < Blueprinter::Base
  identifier :id

  fields :product_id
  fields :name

  fields :option_type_type, :option_type_status, :status
  fields :created_at, :updated_at
end
