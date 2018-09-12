class AddSellingPolicyToVariants < ActiveRecord::Migration[5.1]
  def change
    add_column :variants, :selling_policy, :integer, default: 0
  end
end
