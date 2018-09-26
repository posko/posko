class AddCostToVariants < ActiveRecord::Migration[5.1]
  def change
    add_column :variants, :cost, :decimal
    add_index :products, [:account_id, :handle], unique: true
  end
end
