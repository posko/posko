class RemoveTitleFromVariants < ActiveRecord::Migration[5.1]
  def up
    remove_column :variants, :title
  end

  def down
    add_column :variants, :title, :string
  end
end
