class CreateOptionTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :option_types do |t|
      t.bigint :product_id
      t.string :name, null: false

      t.integer :option_type_type, default: 0
      t.integer :option_type_status, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
