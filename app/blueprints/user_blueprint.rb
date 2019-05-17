class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :email
  fields :account_id
  fields :first_name, :middle_name, :last_name, :email, :suffix
  fields :title

  fields :user_type, :user_status, :status

  fields :created_at, :updated_at

  view :destroyed do
    fields :deleted
  end
end
