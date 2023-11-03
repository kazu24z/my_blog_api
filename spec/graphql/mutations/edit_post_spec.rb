require 'rails_helper'

RSpec.describe "Mutations::Resolvers::EditPost", type: :request do
  describe "resolver" do
    before do
      @role = create(:role)
      @user = create(:user, role_id: @role.role_id)
      @post = create(:post, user_id: @user.user_id)
    end

    # TODO: テストケース拡充、処理汎用化
    context "正常系" do
      it "記事編集（status, title, content）" do
        mutation = Resolvers::Mutations::EditPost.new(field: nil, object: nil, context: nil)
        mutation.resolve(post_id: @post.post_id, params: { status: 'open', title: "編集済みタイトル", content: "# 編集済み見出し1" })

        @post.reload.attributes.each do |key, value|
          # 更新カラム以外スキップ
          next if %w[post_id user_id post_date created_at updated_at].include?(key)

          expect(value).to eq(@post.send(key))
        end
      end
    end
  end
end
