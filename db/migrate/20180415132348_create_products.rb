class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :account_id
      t.string :title
      t.string :vendor
      t.string :handle
      t.integer :product_type

      t.integer :status, default: 0
      t.integer :product_status, default: 0

      t.integer :created_by_id # user id

      t.timestamps
    end
  end
end
