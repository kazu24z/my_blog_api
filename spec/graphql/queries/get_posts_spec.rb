require 'rails_helper'

RSpec.describe "Resolvers::Queries::CreatePost", type: :request do
  describe "resolver" do
    before do
      # Postsを3つ作成
      3.times do |i|
        @user = ::User.find(1)
        @user.posts.create(title: "テストタイトル#{i + 1}", content: "テストコンテンツ#{i + 1}", status: 'draft', post_date: Time.now)
      end
    end

    # TODO: テストケース拡充、処理汎用化
    context "正常系" do
      it "記事一覧を取得できる" do
        query = Resolvers::Queries::GetPosts.new(field: nil, object: nil, context: nil)
        result = query.resolve(user_id: 1)
        posts = @user.posts
        expect(result).to eq posts
      end
    end
  end
end
