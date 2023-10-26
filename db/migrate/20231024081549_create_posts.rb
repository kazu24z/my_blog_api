class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts, id: false do |t|
      t.bigint :post_id, null: false, primary_key: true, auto_increment: true
      t.references :user, null: false, foreign_key: { to_table: :users, primary_key: :user_id }
      t.integer :status, default: 0, null: false
      t.string :title, limit: 255, null: true
      t.text :content, null: true
      t.datetime :post_date, null: true
      t.timestamps
    end
  end
end
