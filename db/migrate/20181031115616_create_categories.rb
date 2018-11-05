class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.bigint  :account_id
      t.bigint  :parent_id
      t.string  :name, null: false
      t.integer :depth, null: false
      t.string  :directory, null: false

      t.integer  :status, default: 0
      t.integer  :category_status, default: 0
      t.timestamps
    end
  end
end
