require 'rails_helper'

RSpec.describe "Mutations::Resolvers::CreatePost", type: :request do
  describe "resolver" do
    # TODO:テストケース拡充、処理汎用化
    context "正常系" do
      it "記事が作成されている" do
        mutation = Resolvers::Mutations::CreatePost.new(field: nil, object: nil, context: nil)
        result = mutation.resolve(params: { status: 'draft', title: "テストタイトル", content: "#見出し1" })
        post = ::Post.last
        expect(result).to eq post
      end
    end
  end
end
