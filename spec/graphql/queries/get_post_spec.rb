require 'rails_helper'

RSpec.describe "Resolvers::Queries::GetPost", type: :request do
  describe "resolver" do
    before do
      created_posts = []
      # Postsを3つ作成
      3.times do |i|
        @user = ::User.find(1)
        created_posts << @user.posts.create(title: "テストタイトル#{i + 1}", content: "テストコンテンツ#{i + 1}", status: 'draft', post_date: Time.now)
      end

      # postのIDリスト
      @post_ids = created_posts.map(&:id)
    end

    # TODO: テストケース拡充、処理汎用化
    context "正常系" do
      it "記事一覧を取得できる" do
        query = Resolvers::Queries::GetPost.new(field: nil, object: nil, context: nil)
        result = query.resolve(user_id: 1, post_id: @post_ids[0])
        post = @user.posts.find(@post_ids[0])
        expect(result).to eq post
      end
    end
  end
end
