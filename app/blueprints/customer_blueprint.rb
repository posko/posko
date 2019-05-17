class CustomerBlueprint < Blueprinter::Base
  identifier :id

  fields :first_name, :middle_name, :last_name, :email, :suffix, :note

  fields :customer_type, :customer_status, :status
  fields :created_at, :updated_at

  association :default_address, blueprint: AddressBlueprint, default: {}
end
