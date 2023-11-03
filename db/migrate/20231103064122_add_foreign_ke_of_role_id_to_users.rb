class AddForeignKeOfRoleIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :users, :roles, column: :role_id, primary_key: "role_id"
  end
end
