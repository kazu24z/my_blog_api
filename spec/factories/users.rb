FactoryBot.define do
  factory :user do
    user_name { "admin_user" }
    email { "test@example.com" }
    password { "password" }

    # リレーションRole
    # role
  end
end
