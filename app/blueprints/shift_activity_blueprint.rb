class ShiftActivityBlueprint < Blueprinter::Base
  identifier :id
  fields :shift_id

  fields :date, :remarks

  fields :amount

  fields :shift_activity_type, :shift_activity_status, :status

  fields :created_at, :updated_at
end
