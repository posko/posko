class CreateOptionValueVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :option_value_variants do |t|
      t.bigint :variant_id
      t.bigint :option_value_id

      t.integer :option_value_variant_status, default: 0
      t.integer :status, default: 0
      t.integer :option_value_variant_type, default: 0
      t.timestamps
    end

    add_index :option_value_variants, :variant_id
    add_index :option_value_variants, :option_value_id
    add_index :option_value_variants, [:variant_id, :option_value_id]
  end
end
