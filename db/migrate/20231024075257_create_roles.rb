class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles, id: false do |t|
      t.bigint :role_id, null: false, primary_key: true, auto_increment: true
      t.string :role_name, limit: 20, null: false
      t.timestamps
    end
  end
end
