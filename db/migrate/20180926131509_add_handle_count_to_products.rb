class AddHandleCountToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :handle_count, :integer, default: 0
  end
end
