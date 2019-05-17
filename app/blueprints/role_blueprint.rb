class RoleBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :level, :code
  fields :description
  fields :account_id

  fields :role_type, :role_status, :status

  fields :created_at, :updated_at
end
