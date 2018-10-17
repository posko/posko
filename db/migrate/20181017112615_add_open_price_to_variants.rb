class AddOpenPriceToVariants < ActiveRecord::Migration[5.1]
  def change
    add_column :variants, :open_price, :boolean, default: false
  end
end
