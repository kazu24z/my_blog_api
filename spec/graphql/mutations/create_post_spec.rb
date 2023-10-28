require 'rails_helper'

RSpec.describe "Mutations::Resolvers::CreatePost", type: :request do
  describe "resolve" do
    # MEMO: Rspecの遅延評価ヘルパ：userメソッドが最初に呼び出された時にcreateを実行する
    let(:user) { create(:user) }

    def default_title
      "テストタイトル"
    end

    def default_content
      "# テストタイトルについてのブログ  ## 見出し2  ### 見出し3"
    end

    def default_status
      "draft"
    end

    context "正常系" do
      it "記事が作成されている" do
        params = [
          user_id: user.id,
          title: default_title,
          content: default_content,
          status: default_status
        ]

        expect do
          post "/graphql",
               params: {
                 query:
                  query(
                    params
                  )
               }
        end.to change { Post.count }.by(1)

        post = Post.last
        expect(post.title).to eq(params[:title])
      end
    end
  end

  def query(arguments)
    <<~GQL
      mutation {
        sendInquiry(#{arguments.join(', ')}){
          postId
          userId
          status
          title
          content
          postDate
        }
      }
    GQL
  end
end
