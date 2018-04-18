class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.integer  :customer_id

      t.string   :address1
      t.string   :address2
      t.string   :city
      t.string   :country_name
      t.string   :country_code
      t.string   :company
      t.string   :first_name
      t.string   :last_name
      t.string   :middle_name
      t.string   :suffix
      t.string   :phone
      t.string   :province
      t.string   :zip
      t.boolean  :default, default: false

      t.integer  :address_status, default: 0
      t.integer  :status, default: 0
      t.timestamps
    end
  end
end
