class AccountBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :company
  fields :account_status, :account_type, :status
end
