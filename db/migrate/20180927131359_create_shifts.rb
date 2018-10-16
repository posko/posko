class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts do |t|
      t.bigint :user_id

      t.date :start_date
      t.date :end_date
      t.decimal :starting_cash
      t.decimal :payments
      t.decimal :paid_in
      t.decimal :paid_out
      t.decimal :cash

      t.integer :status, default: 0
      t.integer :shift_status, default: 0
      t.integer :shift_type, default: 0
      t.timestamps
    end

    add_index :shifts, :user_id
  end
end
