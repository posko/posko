class AddressBlueprint < Blueprinter::Base
  identifier :id

  fields :address1, :address2, :city, :country_name, :country_code, :company,
    :first_name, :last_name, :middle_name, :suffix, :phone, :province, :zip,
    :default

  fields :address_status, :status
  fields :created_at, :updated_at

  association :customer, blueprint: CustomerBlueprint, default: {}
end
