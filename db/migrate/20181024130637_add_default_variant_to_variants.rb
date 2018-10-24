class AddDefaultVariantToVariants < ActiveRecord::Migration[5.1]
  def change
    add_column :variants, :default, :boolean, default: false
  end
end
