class CreateComponents < ActiveRecord::Migration[5.1]
  def change
    create_table :components do |t|
      t.integer :variant_id
      t.decimal :quantity
      t.decimal :cost

      t.integer :status, default: 0
      t.integer :component_status, default: 0
      t.integer :component_type, defualt: 0
      t.timestamps
    end

    add_index :components, :variant_id
  end
end
