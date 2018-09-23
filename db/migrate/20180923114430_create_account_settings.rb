class CreateAccountSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :account_settings do |t|
      t.boolean :tax_feature
      t.boolean :shifts_feature
      t.boolean :discounts_feature
      t.timestamps
    end
  end
end
