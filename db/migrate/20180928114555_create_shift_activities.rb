class CreateShiftActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :shift_activities do |t|
      t.bigint :shift_id
      t.date :date
      t.text :remarks
      t.decimal :amount

      t.integer :shift_activity_type, default: 0
      t.integer :shift_activity_status, default: 0
      t.integer :status, default: 0
      t.timestamps
    end

    add_index :shift_activities, :shift_id
  end
end
