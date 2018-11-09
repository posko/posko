class CreateOptionValues < ActiveRecord::Migration[5.1]
  def change
    create_table :option_values do |t|
      t.bigint :option_type_id
      t.string :name
      t.integer :option_value_type, default: 0
      t.integer :option_value_status, default: 0
      t.integer :status, default: 0
      t.timestamps
    end

    add_index :option_values, :option_type_id
  end
end
