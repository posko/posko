class AccountBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :company
  fields :account_status, :account_type, :status

  fields :created_at, :updated_at
end
