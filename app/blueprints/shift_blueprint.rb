class ShiftBlueprint < Blueprinter::Base
  identifier :id
  fields :user_id

  fields :start_date, :end_date

  fields :starting_cash, :payments, :paid_in, :paid_out, :cash

  fields :shift_type, :shift_status, :status

  fields :created_at, :updated_at
end
