class CreateClassifications < ActiveRecord::Migration[5.1]
  def change
    create_table :classifications do |t|
      t.bigint :category_id
      t.bigint :product_id

      t.integer :classification_status, default: 0
      t.integer :classification_type, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
    add_index :classifications, :category_id
    add_index :classifications, :product_id
    add_index :classifications, [:category_id, :product_id]
  end
end
