class AccessKeyBlueprint < Blueprinter::Base
  identifier :id
  fields :token, :auth_token

  fields :access_key_status, :status

  fields :created_at, :updated_at
end
