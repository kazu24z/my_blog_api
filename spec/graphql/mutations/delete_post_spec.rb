require 'rails_helper'

RSpec.describe "Mutations::Resolvers::DeletePost", type: :request do
  describe "resolver" do
    # TODO: テストケース拡充、処理汎用化
    context "正常系" do
      before do
        # ロールを作成
        @role = create(:role)
        # ユーザーを１人作成
        @user = create(:user, role_id: @role.role_id)
        # 投稿を１つ作成
        @post = create(:post, user_id: @user.user_id)
      end

      it "記事が削除されている" do
        mutation = Resolvers::Mutations::DeletePost.new(field: nil, object: nil, context: nil)
        expect do
          mutation.resolve(user_id: @user.user_id, post_id: @post.post_id)
        end.to change {
          ::Post.exists?(@post.post_id)
        }.from(true)
         .to(false)
      end
    end
  end
end
