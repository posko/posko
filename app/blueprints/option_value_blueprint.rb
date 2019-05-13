class OptionValueBlueprint < Blueprinter::Base
  identifier :id

  fields :name

  fields :option_value_type, :option_value_status, :status
  fields :created_at, :updated_at
end
