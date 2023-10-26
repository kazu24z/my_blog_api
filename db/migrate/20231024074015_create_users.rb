class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: false do |t|
      t.bigint :user_id, null: false, primary_key: true, auto_increment: true
      t.string :user_name, limit: 255
      t.string :email, limit: 255
      t.string :password, limit: 255
      t.integer :role_id, null: false

      t.timestamps
    end
  end
end
