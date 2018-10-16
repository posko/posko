class CreateAccountSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :account_settings do |t|
      t.boolean :tax_feature, default: false
      t.boolean :shifts_feature, default: false
      t.boolean :discounts_feature, default: false
      t.bigint  :account_id
      t.timestamps
    end
  end
end
