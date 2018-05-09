class CreateAccessKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :access_keys do |t|
      t.bigint    :user_id
      t.string    :token
      t.string    :auth_token

      t.integer   :access_key_status, default: 0
      t.integer   :status, default: 0
      t.timestamps
    end
    add_index :access_keys, :user_id
    add_index :access_keys, :token, unique: true
  end
end
