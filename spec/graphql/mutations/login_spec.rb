require 'rails_helper'

RSpec.describe "Mutations::Resolvers::login", type: :request do
  describe "resolver" do
    before do
      # ロールを作成
      @admin_role = Role.create(role_name: 'admin')
      # ユーザーを作成
      @user = User.create(user_name: 'admin_user', email: "test@example.com", password: "password", role_id: @admin_role.role_id)
    end

    # TODO: テストケース拡充、処理汎用化
    context "ログイン正常系" do
      it "トークンが発行される" do
        mutation = Resolvers::Mutations::Login.new(field: nil, object: nil, context: nil)
        result = mutation.resolve(email: @user.email, password: @user.password)

        expect(result[:token]).to be_an_instance_of(String)
      end
    end
  end
end
