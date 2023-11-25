# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# rolesテーブルにデータを追加
unless Role.find_by(role_id: 1)
  Role.create!(
    role_id: 1,
    role_name: 'admin'
  )
end

# usersテーブルにデータを追加
user = User.create!(
  user_name: 'admin_user',
  email: 'test@example.com',
  password: 'password',
  role_id: 1
)

# postsテーブルにデータを追加
3.times { |n| Post.create(user_id: 1, status: 0, title: "テストタイトル#{n + 1}", content: '# 見出し ## 中項目 ### 小項目', post_date: Time.now) } if user.user_id == 1
